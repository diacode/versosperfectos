class AddOldForumIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :old_forum_id, :integer

  end
end
