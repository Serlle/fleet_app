require 'rails_helper'

RSpec.describe "vehicles/new", type: :view do
  before(:each) do
    assign(:vehicle, Vehicle.new(
      vin: "MyString",
      plate: "MyString",
      brand: "MyString",
      model: "MyString",
      year: 1,
      status: 1
    ))
  end

  it "renders new vehicle form" do
    render

    assert_select "form[action=?][method=?]", vehicles_path, "post" do

      assert_select "input[name=?]", "vehicle[vin]"

      assert_select "input[name=?]", "vehicle[plate]"

      assert_select "input[name=?]", "vehicle[brand]"

      assert_select "input[name=?]", "vehicle[model]"

      assert_select "input[name=?]", "vehicle[year]"

      assert_select "select[name=?]", "vehicle[status]"
    end
  end
end
