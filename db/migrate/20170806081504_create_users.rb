class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :slack_access_token
      t.string :slack_user_name

      t.timestamps
    end
  end
end
