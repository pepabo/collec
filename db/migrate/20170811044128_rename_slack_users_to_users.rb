class RenameSlackUsersToUsers < ActiveRecord::Migration[5.1]
  def self.up
    rename_table :slack_users, :users
    rename_column :users, :user_id, :slack_id
    rename_column :messages, :slack_user_id, :user_id
    rename_column :mentions, :user_id, :slack_id
  end

  def self.down
    rename_table :users, :slack_users
    rename_column :slack_users, :slack_id, :user_id
    rename_column :messages, :user_id, :slack_user_id
    rename_column :mentions, :slack_id, :user_id
  end
end
