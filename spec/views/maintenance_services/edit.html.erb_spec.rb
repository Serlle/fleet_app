require 'rails_helper'

RSpec.describe "maintenance_services/edit", type: :view do
  let(:maintenance_service) {
  vehicle = FactoryBot.create(:vehicle, vin: "VEDIT", plate: "PEdit", brand: "B", model: "M", year: 2000, status: :active)
  FactoryBot.create(:maintenance_service, vehicle: vehicle, description: "MyText", status: :in_progress, cost_cents: 100, priority: :medium, date: Date.today)
  }

  before(:each) do
    assign(:maintenance_service, maintenance_service)
  end

  it "renders the edit maintenance_service form" do
    render

  assert_select "form", 1
  end
end
