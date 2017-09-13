class Message < ApplicationRecord
  belongs_to :user
  has_many :mentions
  has_many :message_buttons
  has_many :message_answers

  enum button_type: %w(single multi)

  def self.calc_percentage(num, total)
    ( num / total.to_f) * 100
  end
end
