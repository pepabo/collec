class AddTsToMention < ActiveRecord::Migration[5.1]
  def change
    add_column :mentions, :channel, :string, comment: 'ts to determine sended DM'
    add_column :mentions, :ts, :string, comment: 'channel to determine sended DM'
  end
end
