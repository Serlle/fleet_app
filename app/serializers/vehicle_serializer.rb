class VehicleSerializer < ActiveModel::Serializer
  attributes :id, :vin, :plate, :brand, :model, :year, :status
end
