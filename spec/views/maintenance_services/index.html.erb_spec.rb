require 'rails_helper'

RSpec.describe "maintenance_services/index", type: :view do
  before(:each) do
    vehicle = FactoryBot.create(:vehicle)
    assign(:vehicle, vehicle)
    assign(:maintenance_services, [
      FactoryBot.create(:maintenance_service, vehicle: vehicle, description: "MyText", status: :completed, cost_cents: 300, priority: :high, date: Date.today),
      FactoryBot.create(:maintenance_service, vehicle: vehicle, description: "MyText", status: :completed, cost_cents: 300, priority: :high, date: Date.today)
    ])
  end

  it "renders a list of maintenance_services" do
    render
    cell_selector = 'div>p'
  assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  assert_select cell_selector, text: Regexp.new("completed".to_s), count: 2
  assert_select cell_selector, text: Regexp.new("300".to_s), count: 2
  assert_select cell_selector, text: Regexp.new("high".to_s), count: 2
  end
end
