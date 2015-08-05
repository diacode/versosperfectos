class AddFavCountColumnToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :fav_count, :integer, default: 0
  end
end
