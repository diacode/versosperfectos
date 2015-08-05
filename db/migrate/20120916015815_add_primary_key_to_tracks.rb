class AddPrimaryKeyToTracks < ActiveRecord::Migration
  def change
    # Borramos este index que era la antigua clave primaria compuesta por (song_id, album_id)
    execute <<-SQL
        ALTER TABLE tracks DROP PRIMARY KEY
    SQL

    add_column :tracks, :id, :primary_key
  end
end
