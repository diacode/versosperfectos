class RenameArtistFanJoinTable < ActiveRecord::Migration
  def change
  	p "Borrando antigua clave primaria"
  	execute <<-SQL
  	    ALTER TABLE usuario_autor_favorito DROP PRIMARY KEY
  	SQL

  	rename_table :usuario_autor_favorito, :artist_likes
  	rename_column :artist_likes, :id_usuario, :user_id
  	rename_column :artist_likes, :id_autor, :artist_id

  	add_index :artist_likes, [:user_id, :artist_id]
  end
end
