class MessageAnswer < ApplicationRecord
  belongs_to :message
  belongs_to :mention
  belongs_to :message_button
end
