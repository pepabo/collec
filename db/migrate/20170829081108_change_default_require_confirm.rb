class ChangeDefaultRequireConfirm < ActiveRecord::Migration[5.1]
  def change
    change_column :messages, :require_confirm, :boolean, default: false, comment: 'Flag to use confirmation dialog'
  end
end
