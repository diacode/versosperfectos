class CreateFeaturedBlocks < ActiveRecord::Migration
  def change
    create_table :featured_blocks do |t|
      t.string :title
      t.string :link
      t.string :picture
      t.integer :slot

      t.timestamps
    end
  end
end
