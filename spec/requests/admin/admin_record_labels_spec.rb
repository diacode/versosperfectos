require 'spec_helper'

describe "Admin::RecordLabels" do
  describe "GET /admin_record_labels" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get admin_record_labels_path
      response.status.should be(200)
    end
  end
end
