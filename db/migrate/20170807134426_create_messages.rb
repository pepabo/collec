class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true
      t.text :message, comment: 'Request message'
      t.datetime :dut_at, comment: 'Due to answer the request'
      t.boolean :require_confirm, default: 0, comment: 'Flag to use confirmation dialog'

      t.timestamps
    end
  end
end
