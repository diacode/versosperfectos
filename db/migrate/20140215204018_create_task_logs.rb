class CreateTaskLogs < ActiveRecord::Migration
  def change
    create_table :task_logs do |t|
      t.string :purpose
      t.text :stdout
      t.text :stderr
      t.datetime :created_at
    end
  end
end
