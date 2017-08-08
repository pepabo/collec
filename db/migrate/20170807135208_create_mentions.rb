class CreateMentions < ActiveRecord::Migration[5.1]
  def change
    create_table :mentions do |t|
      t.references :message, foreign_key: true
      t.integer :user_id, comment: "Mentioned user's slack user ID"

      t.timestamps
    end
  end
end
