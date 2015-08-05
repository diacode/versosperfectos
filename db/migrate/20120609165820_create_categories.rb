class CreateCategories < ActiveRecord::Migration
  def change
    rename_column :categoria, :nombre, :name
    rename_column :categoria, :permalink, :slug
    rename_table :categoria, :categories
  end
end
