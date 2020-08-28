require "rails_helper"

RSpec.describe StressesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/stresses").to route_to("stresses#index")
    end

    it "routes to #new" do
      expect(get: "/stresses/new").to route_to("stresses#new")
    end

    it "routes to #show" do
      expect(get: "/stresses/1").to route_to("stresses#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/stresses/1/edit").to route_to("stresses#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/stresses").to route_to("stresses#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/stresses/1").to route_to("stresses#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/stresses/1").to route_to("stresses#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/stresses/1").to route_to("stresses#destroy", id: "1")
    end
  end
end
