class CreateSongFiles < ActiveRecord::Migration
  def change
    rename_table :descarga, :song_files
    rename_column :song_files, :id_cancion, :song_id
    rename_column :song_files, :num_descargas, :downloads
    rename_column :song_files, :id_punchline, :punchline_id
    rename_column :song_files, :num_reproducciones, :plays
    rename_column :song_files, :nombre_archivo, :audio
  end
end
