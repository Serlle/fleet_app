require 'rails_helper'

RSpec.describe "maintenance_services/show", type: :view do
  before do
    vehicle = FactoryBot.create(:vehicle, vin: "VIN999", plate: "PL999", brand: "B", model: "M", year: 2000, status: :active)
    assign(:maintenance_service,
      FactoryBot.create(:maintenance_service, :completed, vehicle: vehicle,
             description: "MyText", cost_cents: 300, priority: :high, date: Date.today)
    )
  end
  it "renders attributes in <p>" do
    render
  expect(rendered).to match(/MyText/)
  expect(rendered).to match(/completed/)
  expect(rendered).to match(/300/)
  expect(rendered).to match(/high/)
  end
end
