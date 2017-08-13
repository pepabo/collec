class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def slack
    request.env['omniauth.strategy'].options[:provider_ignores_state] = true
    @user = User.find_for_slack_oauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Slack") if is_navigational_format?
    else
      redirect_to new_user_session_path
    end
  end
end
