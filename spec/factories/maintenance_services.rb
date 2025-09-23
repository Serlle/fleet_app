# spec/factories/maintenance_services.rb
FactoryBot.define do
  factory :maintenance_service do
    association :vehicle
    description { "MyText" }
    status      { :pending }
    priority    { :medium }
    cost_cents  { 300 }
    date        { Date.today - 1 }

    trait :in_progress do
      status { :in_progress }
    end

    trait :completed do
      status       { :completed }
      completed_at { Time.current }
    end
  end
end
