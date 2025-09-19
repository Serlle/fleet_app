class Vehicle < ApplicationRecord
  enum status: { active: 0, inactive: 1, in_maintenance: 2 }

  has_many :maintenance_services, dependent: :destroy

  validates :vin, presence: true, uniqueness: { case_sensitive: false }
  validates :plate, presence: true, uniqueness: { case_sensitive: false }
  validates :brand, presence: true
  validates :model, presence: true
  validates :year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1990, less_than_or_equal_to: 2050 }
end
