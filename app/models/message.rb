class Message < ApplicationRecord
  belongs_to :slack_user
  has_many :mentioned_users
  has_many :message_buttons
  has_many :message_answers
end
