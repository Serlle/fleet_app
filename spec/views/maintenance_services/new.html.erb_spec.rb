require 'rails_helper'

RSpec.describe "maintenance_services/new", type: :view do
  before(:each) do
  vehicle = FactoryBot.create(:vehicle, vin: "VIN999", plate: "PL999", brand: "B", model: "M", year: 2000, status: :active)
  assign(:maintenance_service, FactoryBot.build(:maintenance_service, vehicle: vehicle, description: "MyText", status: :in_progress, cost_cents: 100, priority: :medium, date: Date.today))
  end

  it "renders new maintenance_service form" do
    render

  # a form should be rendered for the maintenance service
  assert_select "form", 1
  end
end
