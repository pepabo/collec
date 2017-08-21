class Api::V1::Slack::UsersController < ApplicationController
  def index
    @users = [ { slack_id: "UHOGE", name: "hypermkt", real_name: "千葉 誠 Makoto Chiba (バーチー)", avatar_url: "http://hoge.io/001.jpg" } ]
  end
end
