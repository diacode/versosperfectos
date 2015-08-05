require 'spec_helper'

describe "admin/artists/show" do
  before(:each) do
    @admin_artist = assign(:admin_artist, stub_model(Admin::Artist,
      :name => "Name",
      :real_name => "Real Name",
      :bio => "MyText",
      :management_id => 1,
      :international => false,
      :mc => false,
      :producer => false,
      :dj => false,
      :clip_director => false,
      :group => false,
      :web => "Web",
      :myspace => "Myspace",
      :dissolved => false,
      :twitter => "Twitter",
      :birth_place_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Real Name/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/Web/)
    rendered.should match(/Myspace/)
    rendered.should match(/false/)
    rendered.should match(/Twitter/)
    rendered.should match(/2/)
  end
end
