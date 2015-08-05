class CreatePosts < ActiveRecord::Migration
  def change
		# Column renaming
		rename_column :noticia, :titulo, :title
		rename_column :noticia, :contenido, :content
		rename_column :noticia, :fecha_hora, :published_at
		rename_column :noticia, :id_posteador, :poster_id
		rename_column :noticia, :id_ultimo_editor, :last_editor_id
		rename_column :noticia, :internacional, :international
		rename_column :noticia, :borrador, :draft
		rename_column :noticia, :lecturas_totales, :total_read_count
		rename_column :noticia, :lecturas_semana_actual, :week_read_count
		rename_column :noticia, :num_comentarios, :comments_count
		rename_column :noticia, :fecha_ultima_edicion, :updated_at
		rename_column :noticia, :comentarios_cerrados, :closed_comments

		remove_column :noticia, :id_post_facebook


		# FK's

		# Table name
		rename_table :noticia, :post
	end
end
