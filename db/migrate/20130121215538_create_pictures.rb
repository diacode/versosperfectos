class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :image
      t.integer :artist_id
      
      t.timestamps
    end
  end
end
