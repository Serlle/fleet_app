class VehicleSerializer < ActiveModel::Serializer
  attributes :vin, :plate, :brand, :model, :year, :status
end
