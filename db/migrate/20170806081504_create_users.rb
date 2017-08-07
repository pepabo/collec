class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :slack_id, comment: 'SlackのユーザーID'
      t.string :access_token, comment: 'Slack APIのアクセストークン'
      t.string :name, comment: 'Slackのユーザー名'

      t.timestamps
    end
  end
end
