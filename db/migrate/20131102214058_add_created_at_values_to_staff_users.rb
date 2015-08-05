class AddCreatedAtValuesToStaffUsers < ActiveRecord::Migration
  def change
    User.update_all({created_at: '2007-01-01 00:00:00'}, 'created_at IS NULL')
  end
end
