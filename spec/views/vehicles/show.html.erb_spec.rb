require 'rails_helper'

RSpec.describe "vehicles/show", type: :view do
  before(:each) do
    assign(:vehicle, Vehicle.create!(
      vin: "Vin",
      plate: "Plate",
      brand: "Brand",
      model: "Model",
      year: 2,
      status: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Vin/)
    expect(rendered).to match(/Plate/)
    expect(rendered).to match(/Brand/)
    expect(rendered).to match(/Model/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
