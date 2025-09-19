FactoryBot.define do
  factory :vehicle do
    vin { "MyString" }
    plate { "MyString" }
    brand { "MyString" }
    model { "MyString" }
    year { 2020 }
    status { 0 }
  end
end
