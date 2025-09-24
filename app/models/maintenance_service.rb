class MaintenanceService < ApplicationRecord
  belongs_to :vehicle

  enum status: { pending: 0, in_progress: 1, completed: 2 }
  enum priority: { low: 0, medium: 1, high: 2 }

  validates :description, presence: true
  validates :date, presence: true
  validates :cost_cents, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: statuses.keys }
  validates :priority, inclusion: { in: priorities.keys }

  validate :completed_at_required_if_completed

  after_save :update_vehicle_status
  after_destroy :update_vehicle_status

  monetize :cost_cents, with_model_currency: :USD

  scope :between_dates, ->(from, to) { where(date: from..to) }
  scope :with_vehicle,  -> { joins(:vehicle) } # use for plate/grouping
  scope :sum_cost_by_status,  -> { group(:status).sum(:cost_cents) }

  # Hash: { "ABC123" => 12345, ... } using vehicle plate
  scope :sum_cost_by_plate, -> {
    with_vehicle.group('vehicles.plate').sum(:cost_cents)
  }

  # Array of [plate, total_cents], ordered desc, limited in SQL
  def self.top_vehicles_by_cost(from:, to:, limit: 3)
    between_dates(from, to)
      .with_vehicle
      .select('vehicles.plate AS plate, SUM(cost_cents) AS total_cents')
      .group('vehicles.plate')
      .order('total_cents DESC')
      .limit(limit)
      .map { |r| [r.plate, r.total_cents.to_i] }
  end

  private

  def completed_at_required_if_completed
    if status == "completed" && completed_at.nil?
      errors.add(:completed_at, "must be set when status is completed")
    end
  end

  def update_vehicle_status
    vehicle.update_status_based_on_services
  end
end
