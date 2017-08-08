class CreateSlackUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :slack_users do |t|
      t.string :access_token, comment: 'Access Token for Slack API'
      t.string :user_id, comment: 'Slack user ID'
      t.string :name, comment: 'Slack username'

      t.timestamps
    end
  end
end
