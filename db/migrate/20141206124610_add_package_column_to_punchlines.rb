class AddPackageColumnToPunchlines < ActiveRecord::Migration
  def change
    add_column :punchlines, :package, :string
  end
end
