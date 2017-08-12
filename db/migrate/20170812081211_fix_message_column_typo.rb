class FixMessageColumnTypo < ActiveRecord::Migration[5.1]
  def change
    rename_column :messages, :dut_at, :due_at
  end
end
