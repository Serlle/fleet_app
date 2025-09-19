json.extract! vehicle, :id, :vin, :plate, :brand, :model, :year, :status, :created_at, :updated_at
json.url vehicle_url(vehicle, format: :json)
