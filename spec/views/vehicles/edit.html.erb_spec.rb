require 'rails_helper'

RSpec.describe "vehicles/edit", type: :view do
  let(:vehicle) {
  FactoryBot.create(:vehicle, vin: "MyString", plate: "MyString", brand: "MyString", model: "MyString", year: 2000, status: :active)
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
