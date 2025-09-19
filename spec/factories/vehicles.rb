FactoryBot.define do
  factory :vehicle do
  sequence(:vin) { |n| "VIN#{n}" }
  sequence(:plate) { |n| "PLATE#{n}" }
  brand { "Brand" }
  model { "Model" }
  year { 2000 }
  status { :active }
  end
end
