class SlackUser < ApplicationRecord
  has_many :messages
end
