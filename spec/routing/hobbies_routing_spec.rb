require "rails_helper"

RSpec.describe HobbiesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/hobbies").to route_to("hobbies#index")
    end

    it "routes to #new" do
      expect(get: "/hobbies/new").to route_to("hobbies#new")
    end

    it "routes to #show" do
      expect(get: "/hobbies/1").to route_to("hobbies#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/hobbies/1/edit").to route_to("hobbies#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/hobbies").to route_to("hobbies#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/hobbies/1").to route_to("hobbies#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/hobbies/1").to route_to("hobbies#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/hobbies/1").to route_to("hobbies#destroy", id: "1")
    end
  end
end
