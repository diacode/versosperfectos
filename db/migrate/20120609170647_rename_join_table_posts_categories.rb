class RenameJoinTablePostsCategories < ActiveRecord::Migration
  def change
  	rename_column :noticia_categoria, :id_noticia, :post_id
  	rename_column :noticia_categoria, :id_categoria, :category_id
  	rename_table :noticia_categoria, :categories_posts
  end
end
