class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :slack_id
      t.string :access_token
      t.string :name

      t.timestamps
    end
  end
end
