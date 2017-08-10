class Api::V1::MessagesController < ApplicationController
  def index
    @messages = Message.where("slack_user_id = ?", 1)
    render json: @messages
  end
end
