class AddDownloadsColumnToPunchlines < ActiveRecord::Migration
  def change
    add_column :punchlines, :downloads, :integer, default: 0
  end
end
