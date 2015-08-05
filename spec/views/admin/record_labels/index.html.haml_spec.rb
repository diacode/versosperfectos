require 'spec_helper'

describe "admin/record_labels/index" do
  before(:each) do
    assign(:admin_record_labels, [
      stub_model(Admin::RecordLabel),
      stub_model(Admin::RecordLabel)
    ])
  end

  it "renders a list of admin/record_labels" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
