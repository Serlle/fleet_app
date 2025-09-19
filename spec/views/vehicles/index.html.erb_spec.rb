require 'rails_helper'

RSpec.describe "vehicles/index", type: :view do
  before(:each) do
    assign(:vehicles, [
      Vehicle.create!(
        vin: "Vin",
        plate: "Plate",
        brand: "Brand",
        model: "Model",
        year: 2,
        status: 3
      ),
      Vehicle.create!(
        vin: "Vin",
        plate: "Plate",
        brand: "Brand",
        model: "Model",
        year: 2,
        status: 3
      )
    ])
  end

  it "renders a list of vehicles" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Vin".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Plate".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Brand".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Model".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
  end
end
