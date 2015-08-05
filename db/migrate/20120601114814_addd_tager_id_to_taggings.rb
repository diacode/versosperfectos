class AdddTagerIdToTaggings < ActiveRecord::Migration
  def change
  	add_column :taggings, :tagger_id, :integer
  	add_index :taggings, :tagger_id

  	remove_column :taggings, :context
  	add_column :taggings, :context, :string, :default => "tags"
  end

end
