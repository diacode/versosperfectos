require 'spec_helper'

describe "albums/new" do
  before(:each) do
    assign(:album, stub_model(Album,
      :artist_id => 1,
      :title => "MyString",
      :year => 1,
      :format => "MyString",
      :demo => false,
      :info => "MyText",
      :record_label_id => 1,
      :spotify_identifier => "MyString"
    ).as_new_record)
  end

  it "renders new album form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => albums_path, :method => "post" do
      assert_select "input#album_artist_id", :name => "album[artist_id]"
      assert_select "input#album_title", :name => "album[title]"
      assert_select "input#album_year", :name => "album[year]"
      assert_select "input#album_format", :name => "album[format]"
      assert_select "input#album_demo", :name => "album[demo]"
      assert_select "textarea#album_info", :name => "album[info]"
      assert_select "input#album_record_label_id", :name => "album[record_label_id]"
      assert_select "input#album_spotify_identifier", :name => "album[spotify_identifier]"
    end
  end
end
