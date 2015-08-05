class AddTaggerTypeColumnToTaggings < ActiveRecord::Migration
  def change
    add_column :taggings, :tagger_type, :string

  end
end
