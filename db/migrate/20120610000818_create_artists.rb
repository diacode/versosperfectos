class CreateArtists < ActiveRecord::Migration
  def change
    rename_column :autor, :nombre, :name
    rename_column :autor, :nombre_real, :real_name
    rename_column :autor, :internacional, :international
    rename_column :autor, :id_management, :management_id
    rename_column :autor, :productor, :producer
    rename_column :autor, :director, :clip_director
    rename_column :autor, :grupo, :group
    rename_column :autor, :permalink, :slug
    rename_column :autor, :grupo_disuelto, :dissolved
    rename_column :autor, :id_posteador, :inserter_id
    rename_column :autor, :fecha_nacimiento, :birth_date
    rename_column :autor, :fecha_muerte, :death_date
    rename_column :autor, :id_lugar_nacimiento, :birth_place_id

    remove_column :autor, :foto
    remove_column :autor, :num_favs
    remove_column :autor, :foto_obituario

    rename_table :autor, :artists
  end
end
