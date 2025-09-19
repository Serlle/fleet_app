FactoryBot.define do
  factory :maintenance_service do
  association :vehicle
  description { "Routine check" }
  # default to :pending (0) for a new maintenance service
  status { 0 }
  date { Date.today }
  cost_cents { 1000 }
  # default to :low (0)
  priority { 0 }
  completed_at { nil }
  end
end
