require 'spec_helper'

describe "admin/artists/edit" do
  before(:each) do
    @admin_artist = assign(:admin_artist, stub_model(Admin::Artist,
      :name => "MyString",
      :real_name => "MyString",
      :bio => "MyText",
      :management_id => 1,
      :international => false,
      :mc => false,
      :producer => false,
      :dj => false,
      :clip_director => false,
      :group => false,
      :web => "MyString",
      :myspace => "MyString",
      :dissolved => false,
      :twitter => "MyString",
      :birth_place_id => 1
    ))
  end

  it "renders the edit admin_artist form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_artists_path(@admin_artist), :method => "post" do
      assert_select "input#admin_artist_name", :name => "admin_artist[name]"
      assert_select "input#admin_artist_real_name", :name => "admin_artist[real_name]"
      assert_select "textarea#admin_artist_bio", :name => "admin_artist[bio]"
      assert_select "input#admin_artist_management_id", :name => "admin_artist[management_id]"
      assert_select "input#admin_artist_international", :name => "admin_artist[international]"
      assert_select "input#admin_artist_mc", :name => "admin_artist[mc]"
      assert_select "input#admin_artist_producer", :name => "admin_artist[producer]"
      assert_select "input#admin_artist_dj", :name => "admin_artist[dj]"
      assert_select "input#admin_artist_clip_director", :name => "admin_artist[clip_director]"
      assert_select "input#admin_artist_group", :name => "admin_artist[group]"
      assert_select "input#admin_artist_web", :name => "admin_artist[web]"
      assert_select "input#admin_artist_myspace", :name => "admin_artist[myspace]"
      assert_select "input#admin_artist_dissolved", :name => "admin_artist[dissolved]"
      assert_select "input#admin_artist_twitter", :name => "admin_artist[twitter]"
      assert_select "input#admin_artist_birth_place_id", :name => "admin_artist[birth_place_id]"
    end
  end
end
