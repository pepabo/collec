class CreateMessageAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :message_answers do |t|
      t.references :message, foreign_key: true
      t.references :mention, foreign_key: true
      t.references :message_button, foreign_key: true

      t.timestamps
    end
  end
end
