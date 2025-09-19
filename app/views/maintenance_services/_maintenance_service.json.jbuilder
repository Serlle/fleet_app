json.extract! maintenance_service, :id, :vehicle_id, :description, :status, :date, :cost_cents, :priority, :completed_at, :created_at, :updated_at
json.url maintenance_service_url(maintenance_service, format: :json)
