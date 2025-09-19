require 'rails_helper'

RSpec.describe "vehicles/edit", type: :view do
  let(:vehicle) {
    Vehicle.create!(
      vin: "MyString",
      plate: "MyString",
      brand: "MyString",
      model: "MyString",
  year: 2000,
      status: 1
    )
  }

  before(:each) do
    assign(:vehicle, vehicle)
  end

  it "renders the edit vehicle form" do
    render

    assert_select "form[action=?][method=?]", vehicle_path(vehicle), "post" do

      assert_select "input[name=?]", "vehicle[vin]"

      assert_select "input[name=?]", "vehicle[plate]"

      assert_select "input[name=?]", "vehicle[brand]"

      assert_select "input[name=?]", "vehicle[model]"

      assert_select "input[name=?]", "vehicle[year]"

      assert_select "input[name=?]", "vehicle[status]"
    end
  end
end
