require "rails_helper"

RSpec.describe MaintenanceServicesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/maintenance_services").to route_to("maintenance_services#index")
    end

    it "routes to #new" do
      expect(get: "/maintenance_services/new").to route_to("maintenance_services#new")
    end

    it "routes to #show" do
      expect(get: "/maintenance_services/1").to route_to("maintenance_services#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/maintenance_services/1/edit").to route_to("maintenance_services#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/maintenance_services").to route_to("maintenance_services#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/maintenance_services/1").to route_to("maintenance_services#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/maintenance_services/1").to route_to("maintenance_services#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/maintenance_services/1").to route_to("maintenance_services#destroy", id: "1")
    end
  end
end
