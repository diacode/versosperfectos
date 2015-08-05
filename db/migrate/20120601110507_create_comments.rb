class CreateComments < ActiveRecord::Migration
  def change
    rename_column :comentario, :contenido, :content
    rename_column :comentario, :id_usuario, :user_id
    rename_column :comentario, :id_noticia, :post_id
    rename_column :comentario, :fecha_hora, :created_at

    rename_table :comentario, :comment
  end
end
