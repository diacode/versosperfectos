require "spec_helper"

describe Admin::RecordLabelsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/record_labels").should route_to("admin/record_labels#index")
    end

    it "routes to #new" do
      get("/admin/record_labels/new").should route_to("admin/record_labels#new")
    end

    it "routes to #show" do
      get("/admin/record_labels/1").should route_to("admin/record_labels#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/record_labels/1/edit").should route_to("admin/record_labels#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/record_labels").should route_to("admin/record_labels#create")
    end

    it "routes to #update" do
      put("/admin/record_labels/1").should route_to("admin/record_labels#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/record_labels/1").should route_to("admin/record_labels#destroy", :id => "1")
    end

  end
end
