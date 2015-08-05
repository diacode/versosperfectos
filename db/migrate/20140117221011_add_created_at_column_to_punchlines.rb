class AddCreatedAtColumnToPunchlines < ActiveRecord::Migration
  def change
    add_column :punchlines, :created_at, :datetime
  end
end
