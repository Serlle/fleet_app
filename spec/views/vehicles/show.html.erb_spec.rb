require 'rails_helper'

RSpec.describe "vehicles/show", type: :view do
  before(:each) do
  @vehicle = FactoryBot.create(:vehicle)
  assign(:vehicle, @vehicle)
  end

  it "renders attributes in <p>" do
    render
  expect(rendered).to match(/#{@vehicle.vin}/)
  expect(rendered).to match(/#{@vehicle.plate}/)
  expect(rendered).to match(/#{@vehicle.brand}/)
  expect(rendered).to match(/#{@vehicle.model}/)
  expect(rendered).to match(/#{@vehicle.year}/)
  expect(rendered).to match(/#{@vehicle.status}/)
  end
end
