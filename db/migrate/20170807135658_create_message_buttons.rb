class CreateMessageButtons < ActiveRecord::Migration[5.1]
  def change
    create_table :message_buttons do |t|
      t.references :message, foreign_key: true
      t.string :name, comment: 'ユーザーが入力したボタン名'
      t.string :value, comment: 'ユーザーが選択したアクションを識別するための文字列'

      t.timestamps
    end
  end
end
