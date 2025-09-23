# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Reset all the db data
puts "Cleaning database..."
Vehicle.destroy_all
MaintenanceService.destroy_all
puts "Database cleaned!"

# Create 5 vehicles
puts "Creating vehicles..."

vehicles = [
  {
    vin: "1HGBH41JXMN109186",
    plate: "ABC123",
    brand: "Toyota",
    model: "Corolla",
    year: 2020,
    status: :active
  },
  {
    vin: "2FMDK3GC5DBA12345",
    plate: "XYZ789",
    brand: "Ford",
    model: "F-150",
    year: 2021,
    status: :active
  },
  {
    vin: "3VWDP7AJ7DM123456",
    plate: "DEF456",
    brand: "Volkswagen",
    model: "Jetta",
    year: 2019,
    status: :inactive
  },
  {
    vin: "5YJSA1E21HF123456",
    plate: "GHI789",
    brand: "Tesla",
    model: "Model 3",
    year: 2022,
    status: :active
  },
  {
    vin: "WAUZZZ4G6DN123456",
    plate: "JKL012",
    brand: "Audi",
    model: "A4",
    year: 2021,
    status: :in_maintenance
  }
]

vehicles.each do |vehicle_data|
  Vehicle.create!(vehicle_data)
end

puts "Created #{Vehicle.count} vehicles"

# Create 15 maintenance services distributed among vehicles
puts "Creating maintenance services..."

maintenance_services = [
  # Vehicle 1 - Toyota Corolla
  {
    vehicle_id: Vehicle.first.id,
    description: "Oil change and filter replacement",
    status: :completed,
    date: Date.today - 30,
    cost_cents: 7500,
    priority: :medium,
    completed_at: Date.today - 30
  },
  {
    vehicle_id: Vehicle.first.id,
    description: "Tire rotation and balance",
    status: :completed,
    date: Date.today - 15,
    cost_cents: 4500,
    priority: :medium,
    completed_at: Date.today - 15
  },
  {
    vehicle_id: Vehicle.first.id,
    description: "Brake pad replacement",
    status: :in_progress,
    date: Date.today - 5,
    cost_cents: 12500,
    priority: :high
  },

  # Vehicle 2 - Ford F-150
  {
    vehicle_id: Vehicle.second.id,
    description: "Engine tune-up",
    status: :completed,
    date: Date.today - 45,
    cost_cents: 15000,
    priority: :high,
    completed_at: Date.today - 45
  },
  {
    vehicle_id: Vehicle.second.id,
    description: "Transmission fluid change",
    status: :pending,
    date: Date.today + 10,
    cost_cents: 8900,
    priority: :medium
  },
  {
    vehicle_id: Vehicle.second.id,
    description: "Air conditioning service",
    status: :in_progress,
    date: Date.today - 2,
    cost_cents: 11200,
    priority: :low
  },
  {
    vehicle_id: Vehicle.second.id,
    description: "Wheel alignment",
    status: :pending,
    date: Date.today + 20,
    cost_cents: 6500,
    priority: :medium
  },

  # Vehicle 3 - Volkswagen Jetta
  {
    vehicle_id: Vehicle.third.id,
    description: "Battery replacement",
    status: :completed,
    date: Date.today - 60,
    cost_cents: 18500,
    priority: :high,
    completed_at: Date.today - 60
  },
  {
    vehicle_id: Vehicle.third.id,
    description: "Spark plug replacement",
    status: :completed,
    date: Date.today - 25,
    cost_cents: 4200,
    priority: :medium,
    completed_at: Date.today - 25
  },

  # Vehicle 4 - Tesla Model 3
  {
    vehicle_id: Vehicle.fourth.id,
    description: "Software update and diagnostics",
    status: :completed,
    date: Date.today - 10,
    cost_cents: 2500,
    priority: :low,
    completed_at: Date.today - 10
  },
  {
    vehicle_id: Vehicle.fourth.id,
    description: "Brake fluid flush",
    status: :pending,
    date: Date.today + 15,
    cost_cents: 7800,
    priority: :medium
  },
  {
    vehicle_id: Vehicle.fourth.id,
    description: "Tire pressure sensor replacement",
    status: :in_progress,
    date: Date.today - 1,
    cost_cents: 3200,
    priority: :high
  },

  # Vehicle 5 - Audi A4
  {
    vehicle_id: Vehicle.fifth.id,
    description: "Timing belt replacement",
    status: :in_progress,
    date: Date.today - 3,
    cost_cents: 24500,
    priority: :high
  },
  {
    vehicle_id: Vehicle.fifth.id,
    description: "Coolant system flush",
    status: :pending,
    date: Date.today + 5,
    cost_cents: 5600,
    priority: :medium
  },
  {
    vehicle_id: Vehicle.fifth.id,
    description: "Suspension inspection",
    status: :completed,
    date: Date.today - 40,
    cost_cents: 3500,
    priority: :low,
    completed_at: Date.today - 40
  }
]

maintenance_services.each do |service_data|
  MaintenanceService.create!(service_data)
end

puts "Created #{MaintenanceService.count} maintenance services"

# Update vehicle statuses based on their maintenance services
puts "Updating vehicle statuses based on maintenance services..."
Vehicle.all.each do |vehicle|
  vehicle.update_status_based_on_services
  puts "Vehicle #{vehicle.plate} status updated to: #{vehicle.status}"
end

puts "Seeding completed successfully!"
puts "Total vehicles: #{Vehicle.count}"
puts "Total maintenance services: #{MaintenanceService.count}"