class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :score_lyrics
      t.integer :score_production
      t.integer :score_collaborations
      t.integer :score_artwork
      t.integer :votes, default: 0
      t.integer :author_id
      t.integer :album_id

      t.timestamps
    end
  end
end
