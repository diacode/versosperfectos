require 'spec_helper'

describe "admin/record_labels/new" do
  before(:each) do
    assign(:admin_record_label, stub_model(Admin::RecordLabel).as_new_record)
  end

  it "renders new admin_record_label form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_record_labels_path, :method => "post" do
    end
  end
end
