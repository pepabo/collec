class Api::V1::Slack::UsersController < ApplicationController
  def index
    client = Slack::User.new
    @users = client.list
  end
end
