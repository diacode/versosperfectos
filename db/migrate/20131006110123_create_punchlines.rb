class CreatePunchlines < ActiveRecord::Migration
  def change
    rename_table :punchline, :punchlines
    rename_column :punchlines, :id_disco, :album_id
    rename_column :punchlines, :descripcion, :description
    rename_column :punchlines, :fecha_publicacion, :published_at
    rename_column :punchlines, :entradilla, :lead_in
  end
end
