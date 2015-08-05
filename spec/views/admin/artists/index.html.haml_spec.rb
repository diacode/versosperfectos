require 'spec_helper'

describe "admin/artists/index" do
  before(:each) do
    assign(:admin_artists, [
      stub_model(Admin::Artist,
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
      ),
      stub_model(Admin::Artist,
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
      )
    ])
  end

  it "renders a list of admin/artists" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Real Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Web".to_s, :count => 2
    assert_select "tr>td", :text => "Myspace".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Twitter".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
