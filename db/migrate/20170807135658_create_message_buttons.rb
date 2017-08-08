class CreateMessageButtons < ActiveRecord::Migration[5.1]
  def change
    create_table :message_buttons do |t|
      t.references :message, foreign_key: true
      t.string :name, comment: 'String to specify action'
      t.string :text, comment: 'The user-facing label for the message button'

      t.timestamps
    end
  end
end
