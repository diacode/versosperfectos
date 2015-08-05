class AddPortraitColumnToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :portrait, :string

  end
end
