require 'spec_helper'

describe "admin/record_labels/edit" do
  before(:each) do
    @admin_record_label = assign(:admin_record_label, stub_model(Admin::RecordLabel))
  end

  it "renders the edit admin_record_label form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_record_labels_path(@admin_record_label), :method => "post" do
    end
  end
end
