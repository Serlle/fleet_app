# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# reset all the db data
# Vehicle.destroy_all
# MaintenanceService.destroy_all

# Create an initial vehicle if none exist
if Vehicle.count == 0
  Vehicle.create!(
    vin: "1HGBH41JXMN109186",
    plate: "XYZ1234",
    brand: "Toyota",
    model: "Corolla",
    year: 2020,
    status: :active
  )
  puts "Created initial vehicle with VIN 1HGBH41JXMN109186 and plate XYZ1234"
end

# Create varioues maintenance services for the initial vehicle if none exist
if MaintenanceService.count == 0
  vehicle = Vehicle.first
  MaintenanceService.create!([
    {
      vehicle: vehicle,
      description: "Oil change and tire rotation",
      status: :completed,
      cost_cents: 5000,
      priority: :medium,
      date: Date.today - 30
    },
    {
      vehicle: vehicle,
      description: "Brake inspection",
      status: :in_progress,
      cost_cents: 2000,
      priority: :high,
      date: Date.today - 10
    },
    {
      vehicle: vehicle,
      description: "Engine diagnostics",
      status: :pending,
      cost_cents: 15000,
      priority: :low,
      date: Date.today + 15
    }
  ])
  puts "Created initial maintenance services for the initial vehicle"
end