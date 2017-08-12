class FixMessageColumnTypo < ActiveRecord::Migration[5.1]
  def change
    rename_column :messages, :dut_at, :due_at
    change_column :messages, :due_at, :datetime, comment: 'Due to answer the request'
  end
end
