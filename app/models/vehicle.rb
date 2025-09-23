class Vehicle < ApplicationRecord
  enum status: { active: 0, inactive: 1, in_maintenance: 2 }

  has_many :maintenance_services, dependent: :destroy
  
  before_save :upcase_vin_and_plate

  validates :vin, presence: true, uniqueness: { case_sensitive: false }
  validates :plate, presence: true, uniqueness: { case_sensitive: false }
  validates :brand, presence: true
  validates :model, presence: true
  validates :year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1990, less_than_or_equal_to: 2050 }


  def update_status_based_on_services
    if maintenance_services.where(status: [:pending, :in_progress]).exists?
      update!(status: :in_maintenance) unless status == "in_maintenance"
    else
      update!(status: :active) unless status == "active"
    end
  end

  private

  def upcase_vin_and_plate
    self.vin = vin.upcase if vin.present?
    self.plate = plate.upcase if plate.present?
  end
end
