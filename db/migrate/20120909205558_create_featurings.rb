class CreateFeaturings < ActiveRecord::Migration
  def change
    # Borramos este index que era la antigua clave primaria compuesta por (id_cancion, id_autor)
    execute <<-SQL
        ALTER TABLE cancion_participacion DROP PRIMARY KEY
    SQL

    add_column :cancion_participacion, :id, :primary_key

    rename_column :cancion_participacion, :id_cancion, :song_id
    rename_column :cancion_participacion, :id_autor, :artist_id
    rename_column :cancion_participacion, :colab, :collaboration
    rename_column :cancion_participacion, :MC, :mc
    rename_column :cancion_participacion, :PROD, :producer
    rename_column :cancion_participacion, :DJ, :dj
    rename_column :cancion_participacion, :DIRECTOR, :clip_director

    rename_table :cancion_participacion, :featurings
  end
end
