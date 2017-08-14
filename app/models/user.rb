class User < ApplicationRecord
  has_many :messages
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  def self.find_for_slack_oauth(auth)
    User.where(provider: auth.provider, slack_id: auth.uid).first ||
      User.create!(
        name: auth.info.name,
        provider: auth.provider,
        slack_id: auth.uid,
        email: auth.info.email,
        token: auth.credentials.token,
        password: Devise.friendly_token[0,20]
      )
  end

end
