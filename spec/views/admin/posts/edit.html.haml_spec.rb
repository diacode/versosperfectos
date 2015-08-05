require 'spec_helper'

describe "admin_posts/edit" do
  before(:each) do
    @post = assign(:post, stub_model(Admin::Post,
      :title => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_posts_path(@post), :method => "post" do
      assert_select "input#post_title", :name => "post[title]"
      assert_select "textarea#post_content", :name => "post[content]"
    end
  end
end
