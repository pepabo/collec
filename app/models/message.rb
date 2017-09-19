class Message < ApplicationRecord
  belongs_to :user
  has_many :mentions
  has_many :message_buttons
  has_many :message_answers

  enum button_type: %w(single multi)

  def self.calc_percentage(num, total)
    return 0 if total == 0

    # No decimal point required. ex) 36.36363636363637 to 36
    ((num / total.to_f) * 100).round
  end
end
