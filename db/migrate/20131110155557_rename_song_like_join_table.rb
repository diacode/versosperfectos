class RenameSongLikeJoinTable < ActiveRecord::Migration
  def change
    p "Borrando antigua clave primaria"
    execute <<-SQL
        ALTER TABLE usuario_cancion_favorita DROP PRIMARY KEY
    SQL

    p "Migrando los USER_IDs"
    likes = ActiveRecord::Base.connection.select_all("SELECT id_cancion, id_usuario FROM usuario_cancion_favorita")
    
    likes.each do |like|
      u = User.where(old_forum_id: like['id_usuario']).first
      if !u.nil?
        p "Actualizando el like del antiguo usuario #{like['id_usuario']} para la cancion #{like['id_cancion']}"
        ActiveRecord::Base.connection.execute("UPDATE usuario_cancion_favorita SET id_usuario = #{u.id} WHERE id_cancion = #{like['id_cancion']} AND id_usuario = #{like['id_usuario']}")
      end
    end

    p "Renombrando tabla y columnas"
    rename_table :usuario_cancion_favorita, :song_likes
    rename_column :song_likes, :id_usuario, :user_id
    rename_column :song_likes, :id_cancion, :song_id
    
    add_index :song_likes, [:user_id, :song_id]
  end
end
