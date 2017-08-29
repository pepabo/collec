class AddButtonTypeToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :button_type, :integer
  end
end
