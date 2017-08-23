class AddCallbackIdToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :callback_id, :string, comment: 'Unique identifier for the Slack message button'
  end
end
