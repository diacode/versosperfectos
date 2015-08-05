class CreateAlbums < ActiveRecord::Migration
  def change
  	rename_column :disco, :titulo, :title
  	rename_column :disco, :lanzamiento, :release_date
  	rename_column :disco, :tipo, :format
  	rename_column :disco, :maketa, :demo
  	rename_column :disco, :id_autor, :artist_id
  	rename_column :disco, :id_alias_autor, :alias_id
  	rename_column :disco, :permalink, :slug
  	rename_column :disco, :visitas, :visits
  	rename_column :disco, :nota_media, :average_rating
  	rename_column :disco, :votos, :vote_count
  	rename_column :disco, :bloquear_letras, :block_lyrics
  	rename_column :disco, :otra_info, :info
  	rename_column :disco, :id_sello, :record_label_id
  	rename_column :disco, :id_posteador, :inserter_id
  	rename_column :disco, :num_favs, :fav_count
  	rename_column :disco, :lanzamiento_aproximado, :trimester_planned
  	rename_column :disco, :id_album_spotify, :spotify_identifier

  	remove_column :disco, :portada
  	remove_column :disco, :fecha_sin_determinar

  	rename_table :disco, :albums
  end
end
