require 'spec_helper'

describe "Admin::Artists" do
  describe "GET /admin_artists" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get admin_artists_path
      response.status.should be(200)
    end
  end
end
