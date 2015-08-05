class AddSlugToPunchlines < ActiveRecord::Migration
  def change
    add_column :punchlines, :slug, :string
    add_index :punchlines, :slug, unique: true
  end
end
