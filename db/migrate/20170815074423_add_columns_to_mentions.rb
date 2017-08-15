class AddColumnsToMentions < ActiveRecord::Migration[5.1]
  def change
    add_column :mentions, :name, :string, comment: 'Slack user name'
    add_column :mentions, :profile_picture_url, :string
  end
end
