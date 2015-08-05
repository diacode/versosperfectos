class AddFeaturedColumnToPunchlines < ActiveRecord::Migration
  def change
    add_column :punchlines, :featured, :boolean, default: false
  end
end
