class CreateManagements < ActiveRecord::Migration
  def change
  	rename_column :management, :nombre, :name
  	rename_column :management, :telefono, :phone
  	rename_column :management, :permalink, :slug

  	rename_table :management, :managements
  end
end
