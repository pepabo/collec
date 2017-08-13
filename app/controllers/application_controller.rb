class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user!
    return if Rails.env.test?
    session[:user_return_to] = ENV['PATH_INFO']
    redirect_to new_user_session_path unless user_signed_in?
  end
end
