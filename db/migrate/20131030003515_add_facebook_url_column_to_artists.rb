class AddFacebookUrlColumnToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :facebook_url, :string
  end
end
