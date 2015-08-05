class RenameScoreAlbumRatingColumn < ActiveRecord::Migration
  def change
    rename_column :album_ratings, :nota, :score
  end
end
