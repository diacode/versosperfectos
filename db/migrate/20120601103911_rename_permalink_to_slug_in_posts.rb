class RenamePermalinkToSlugInPosts < ActiveRecord::Migration
  def change
  	rename_table :post, :posts
  	rename_column :posts, :permalink, :slug
  end

end
