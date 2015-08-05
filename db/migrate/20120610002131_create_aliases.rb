class CreateAliases < ActiveRecord::Migration
  def change
  	rename_column :autor_alias, :id_autor, :artist_id
  	rename_column :autor_alias, :nombre, :name
  	rename_table :autor_alias, :aliases
  end
end
