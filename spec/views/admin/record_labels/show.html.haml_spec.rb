require 'spec_helper'

describe "admin/record_labels/show" do
  before(:each) do
    @admin_record_label = assign(:admin_record_label, stub_model(Admin::RecordLabel))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
