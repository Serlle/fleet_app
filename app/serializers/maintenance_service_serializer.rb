class MaintenanceServiceSerializer < ActiveModel::Serializer
  attributes :id, :description, :status, :date, :cost_cents, :priority, :completed_at, :vehicle_id, :vehicle

  # Official AMS way
  belongs_to :vehicle

  # Explicitly way

  # # include vehicle id for easy lookups and a compact vehicle object
  # def vehicle_id
  #   object.vehicle_id
  # end

  # def vehicle
  #   return unless object.vehicle
  #   VehicleSerializer.new(object.vehicle, scope: scope, root: false)
  # end
end
