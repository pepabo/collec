class AddMessageColumnToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :mentions, :text, :string, comment: 'current displayed message'
  end
end
