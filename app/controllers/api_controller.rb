class ApiController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  def authenticate_user!
    return if Rails.env.test?
    render text: 'Unauthorized', status: 401 unless user_signed_in?
  end
end
