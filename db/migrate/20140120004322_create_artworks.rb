class CreateArtworks < ActiveRecord::Migration
  def change
    create_table :artworks do |t|
      t.string :title
      t.string :art
      t.integer :punchline_id

      t.timestamps
    end
  end
end
