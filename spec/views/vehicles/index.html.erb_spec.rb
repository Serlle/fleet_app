require 'rails_helper'

RSpec.describe "vehicles/index", type: :view do
  before(:each) do
  @v1 = FactoryBot.create(:vehicle)
  @v2 = FactoryBot.create(:vehicle)
  assign(:vehicles, [@v1, @v2])
  end

  it "renders a list of vehicles" do
    render
  expect(rendered).to match(/#{@v1.vin}/)
  expect(rendered).to match(/#{@v2.vin}/)
  expect(rendered).to match(/#{@v1.plate}/)
  expect(rendered).to match(/#{@v2.plate}/)
  expect(rendered).to match(/#{@v1.brand}/)
  expect(rendered).to match(/#{@v1.model}/)
  expect(rendered).to match(/#{@v1.year}/)
  expect(rendered).to match(/#{@v1.status}/)
  end
end
