require "rails_helper"

RSpec.describe MaintenanceServicesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/vehicles/1/maintenance_services").to route_to("maintenance_services#index", vehicle_id: "1")
    end

    it "routes to #new" do
      expect(get: "/vehicles/1/maintenance_services/new").to route_to("maintenance_services#new", vehicle_id: "1")
    end

    it "routes to #show" do
      expect(get: "/vehicles/1/maintenance_services/1").to route_to("maintenance_services#show", vehicle_id: "1", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/vehicles/1/maintenance_services/1/edit").to route_to("maintenance_services#edit", vehicle_id: "1", id: "1")
    end

    it "routes to #create" do
      expect(post: "/vehicles/1/maintenance_services").to route_to("maintenance_services#create", vehicle_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/vehicles/1/maintenance_services/1").to route_to("maintenance_services#update", vehicle_id: "1", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/vehicles/1/maintenance_services/1").to route_to("maintenance_services#update", vehicle_id: "1", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/vehicles/1/maintenance_services/1").to route_to("maintenance_services#destroy", vehicle_id: "1", id: "1")
    end
  end
end
