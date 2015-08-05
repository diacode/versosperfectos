class CreateAlbumRatings < ActiveRecord::Migration
  def change
    p "Borrando antigua clave primaria"
    execute <<-SQL
        ALTER TABLE disco_puntuacion DROP PRIMARY KEY
    SQL

    p "Migrando los USER_IDs"
    ratings = ActiveRecord::Base.connection.select_all("SELECT id_disco, id_usuario FROM disco_puntuacion")
    
    ratings.each do |rating|
      u = User.where(old_forum_id: rating['id_usuario']).first
      if !u.nil?
        p "Actualizando el rating del antiguo usuario #{rating['id_usuario']} para el disco #{rating['id_disco']}"
        ActiveRecord::Base.connection.execute("UPDATE disco_puntuacion SET id_usuario = #{u.id} WHERE id_disco = #{rating['id_disco']} AND id_usuario = #{rating['id_usuario']}")
      end
    end

    p "Renombrando tabla y columnas"
    rename_table :disco_puntuacion, :album_ratings
    add_column :album_ratings, :id, :primary_key
    rename_column :album_ratings, :id_disco, :album_id
    rename_column :album_ratings, :id_usuario, :user_id
  end
end
