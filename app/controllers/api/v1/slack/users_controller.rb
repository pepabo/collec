class Api::V1::Slack::UsersController < ApplicationController
  def index
    @users = [ { slack_id: "UHOGE", name: "hypermkt", avatar_url: "http://hoge.io/001.jpg" } ]
  end
end
