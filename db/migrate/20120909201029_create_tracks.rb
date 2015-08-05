class CreateTracks < ActiveRecord::Migration
  def change
    rename_column :tracklist, :id_disco, :album_id
    rename_column :tracklist, :id_cancion, :song_id
    rename_column :tracklist, :num_track, :track_number
    rename_table :tracklist, :tracks
  end
end
