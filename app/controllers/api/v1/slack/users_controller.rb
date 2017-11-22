class Api::V1::Slack::UsersController < ApplicationController
  def index
    u = Slack::User.new
    g = Slack::Usergroups.new
    @users = (u.list << g.list).flatten
  end
end
