class MaintenanceServiceSerializer < ActiveModel::Serializer
  attributes :id, :description, :status, :date, :cost_cents, :priority, :completed_at
  has_one :vehicle
end
