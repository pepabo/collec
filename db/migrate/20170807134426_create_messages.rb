class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :slack_user, foreign_key: true
      t.text :message, comment: '依頼文'
      t.datetime :dut_at, comment: '対応期限日'
      t.boolean :require_confirm, default: 0, comment: '確認用ポップアップフラグ 0: 無し 1: 有り'
      t.integer :remind_interval, comment: 'リマインド間隔'

      t.timestamps
    end
  end
end
