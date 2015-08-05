class CreateRecordLabels < ActiveRecord::Migration
  def change
  	rename_column :sello, :nombre, :name
  	rename_column :sello, :internacional, :international
  	rename_column :sello, :telefono, :phone
  	rename_column :sello, :direccion, :address
  	rename_column :sello, :permalink, :slug
  	
  	add_column :sello, :twitter, :string

  	remove_column :sello, :foto
  	remove_column :sello, :id_posteador
  	remove_column :sello, :myspace

  	rename_table :sello, :record_labels
  end
end
