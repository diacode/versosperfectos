require 'spec_helper'

describe "albums/index" do
  before(:each) do
    assign(:albums, [
      stub_model(Album,
        :artist_id => 1,
        :title => "Title",
        :year => 2,
        :format => "Format",
        :demo => false,
        :info => "MyText",
        :record_label_id => 3,
        :spotify_identifier => "Spotify Identifier"
      ),
      stub_model(Album,
        :artist_id => 1,
        :title => "Title",
        :year => 2,
        :format => "Format",
        :demo => false,
        :info => "MyText",
        :record_label_id => 3,
        :spotify_identifier => "Spotify Identifier"
      )
    ])
  end

  it "renders a list of albums" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Format".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Spotify Identifier".to_s, :count => 2
  end
end
