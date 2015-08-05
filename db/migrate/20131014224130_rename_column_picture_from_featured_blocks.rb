class RenameColumnPictureFromFeaturedBlocks < ActiveRecord::Migration
  def change
    rename_column :featured_blocks, :picture, :poster
  end
end
