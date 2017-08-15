class Api::V1::MessagesController < ApplicationController
  def index
    @messages = Message.where("user_id = ?", 1)
  end

  def create
    attributes = params.permit(:message, :require_confirm, :due_at)

    message = Message.new(attributes)
    message.user_id = 1
    message.save

    head :created
  end
end
