class MakePunchlinePublishedAtNullable < ActiveRecord::Migration
  def up
    change_column :punchlines, :published_at, :datetime, null: true
  end

  def down
    change_column :punchlines, :published_at, :datetime, null: false
  end
end
