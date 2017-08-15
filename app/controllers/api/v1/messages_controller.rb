class Api::V1::MessagesController < ApplicationController
  def index
    @messages = Message.where("user_id = ?", 1)
  end

  def show
    @message = Message.includes(:mentions).
               where("user_id = ? and id = ?", 1, params[:id]).first
  end
end
