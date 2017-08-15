class Api::V1::MessagesController < ApplicationController
  def index
    @messages = Message.where("user_id = ?", 1)
  end

  def create
    message_attributes = params.permit(:message, :require_confirm, :due_at)
    message_buttons_attributes = params.permit(message_buttons: [:text])
    mentions_attributes = params.permit(mentions: [:slack_id])

    Message.transaction do
      message = Message.new(message_attributes)
      message.user_id = 1
      message.save

      message_buttons_attributes[:message_buttons].each do |m|
        message_button = MessageButton.new(m)
        message_button.message_id = message.id
        message_button.save
      end

      mentions_attributes[:mentions].each do |m|
        mention = Mention.new(m)
        mention.message_id = message.id
        mention.save
      end
    end

    head :created
  end
end
