class RemoveColumnFotoFromManagements < ActiveRecord::Migration
  def change
  	remove_column :managements, :foto
  end
end
