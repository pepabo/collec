class AddUserGroupIDtoMentions < ActiveRecord::Migration[5.1]
  def change
    add_column :mentions, :user_group_id, :string, comment: 'slack user group'
  end
end
