class RenameAlbumLikeJoinTable < ActiveRecord::Migration
  def change
    p "Borrando antigua clave primaria"
    execute <<-SQL
        ALTER TABLE usuario_disco_favorito DROP PRIMARY KEY
    SQL

    p "Migrando los USER_IDs"
    likes = ActiveRecord::Base.connection.select_all("SELECT id_disco, id_usuario FROM usuario_disco_favorito")
    
    likes.each do |like|
      u = User.where(old_forum_id: like['id_usuario']).first
      if !u.nil?
        p "Actualizando el like del antiguo usuario #{like['id_usuario']} para el disco #{like['id_disco']}"
        ActiveRecord::Base.connection.execute("UPDATE usuario_disco_favorito SET id_usuario = #{u.id} WHERE id_disco = #{like['id_disco']} AND id_usuario = #{like['id_usuario']}")
      end
    end

    p "Renombrando tabla y columnas"
    rename_table :usuario_disco_favorito, :album_likes
    rename_column :album_likes, :id_usuario, :user_id
    rename_column :album_likes, :id_disco, :album_id
  end
end
