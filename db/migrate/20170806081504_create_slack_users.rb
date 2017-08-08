class CreateSlackUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :slack_users do |t|
      t.string :user_id, comment: 'SlackのユーザーID'
      t.string :access_token, comment: 'Slack APIのアクセストークン'
      t.string :name, comment: 'Slackのユーザー名'

      t.timestamps
    end
  end
end
