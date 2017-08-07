class MessageAnswer < ApplicationRecord
  belongs_to :message
  belongs_to :mentioned_user
  belongs_to :message_button
end
