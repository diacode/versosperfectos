require "spec_helper"

describe Admin::ArtistsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/artists").should route_to("admin/artists#index")
    end

    it "routes to #new" do
      get("/admin/artists/new").should route_to("admin/artists#new")
    end

    it "routes to #show" do
      get("/admin/artists/1").should route_to("admin/artists#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/artists/1/edit").should route_to("admin/artists#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/artists").should route_to("admin/artists#create")
    end

    it "routes to #update" do
      put("/admin/artists/1").should route_to("admin/artists#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/artists/1").should route_to("admin/artists#destroy", :id => "1")
    end

  end
end
