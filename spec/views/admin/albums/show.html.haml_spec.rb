require 'spec_helper'

describe "albums/show" do
  before(:each) do
    @album = assign(:album, stub_model(Album,
      :artist_id => 1,
      :title => "Title",
      :year => 2,
      :format => "Format",
      :demo => false,
      :info => "MyText",
      :record_label_id => 3,
      :spotify_identifier => "Spotify Identifier"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Title/)
    rendered.should match(/2/)
    rendered.should match(/Format/)
    rendered.should match(/false/)
    rendered.should match(/MyText/)
    rendered.should match(/3/)
    rendered.should match(/Spotify Identifier/)
  end
end
