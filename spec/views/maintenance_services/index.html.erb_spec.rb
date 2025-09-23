require 'rails_helper'

RSpec.describe "maintenance_services/index", type: :view do
  before(:each) do
    vehicle = FactoryBot.create(:vehicle)

    ms1 = FactoryBot.create(:maintenance_service, :completed, vehicle: vehicle,
             description: "MyText", cost_cents: 300, priority: :high, date: Date.today)
    ms2 = FactoryBot.create(:maintenance_service, :completed, vehicle: vehicle,
             description: "MyText", cost_cents: 300, priority: :high, date: Date.today)

    assign(:vehicle, vehicle)
    scope = MaintenanceService.where(id: [ms1.id, ms2.id]).order(created_at: :desc)
    assign(:maintenance_services, scope.page(1).per(2))
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
