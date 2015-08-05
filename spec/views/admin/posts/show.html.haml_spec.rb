require 'spec_helper'

describe "admin_posts/show" do
  before(:each) do
    @post = assign(:post, stub_model(Admin::Post,
      :title => "Title",
      :content => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
  end
end
