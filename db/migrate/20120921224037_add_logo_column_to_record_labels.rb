class AddLogoColumnToRecordLabels < ActiveRecord::Migration
  def change
    add_column :record_labels, :logo, :string

  end
end
