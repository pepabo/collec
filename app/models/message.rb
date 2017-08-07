class Message < ApplicationRecord
  belongs_to :user
  has_many :mentioned_users
  has_many :message_buttons
  has_many :message_answers
end
