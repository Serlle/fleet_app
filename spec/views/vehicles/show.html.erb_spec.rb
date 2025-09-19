require 'rails_helper'

RSpec.describe "vehicles/show", type: :view do
  before(:each) do
  assign(:vehicle, FactoryBot.create(:vehicle, vin: "Vin", plate: "Plate", brand: "Brand", model: "Model", year: 2005, status: :in_maintenance))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Vin/)
    expect(rendered).to match(/Plate/)
    expect(rendered).to match(/Brand/)
    expect(rendered).to match(/Model/)
  expect(rendered).to match(/2005/)
  expect(rendered).to match(/in_maintenance/)
  end
end
