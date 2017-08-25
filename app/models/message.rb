class Message < ApplicationRecord
  belongs_to :user
  has_many :mentions
  has_many :message_buttons
  has_many :message_answers

  enum button_type: %w(single multi)
end
