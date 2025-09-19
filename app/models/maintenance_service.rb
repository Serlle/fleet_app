class MaintenanceService < ApplicationRecord
  # allow optional vehicle in some tests/views; business logic will enforce presence in controllers as needed
  belongs_to :vehicle, optional: true

  enum status: { pending: 0, in_progress: 1, completed: 2 }
  enum priority: { low: 0, medium: 1, high: 2 }

  validates :description, presence: true
  validates :date, presence: true
  validates :cost_cents, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: statuses.keys }
  validates :priority, inclusion: { in: priorities.keys }

  monetize :cost_cents
end
