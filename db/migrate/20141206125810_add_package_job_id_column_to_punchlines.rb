class AddPackageJobIdColumnToPunchlines < ActiveRecord::Migration
  def change
    add_column :punchlines, :package_job_id, :string
  end
end
