class Api::V1::MessagesController < ApplicationController
  def index
    @messages = Message.where("user_id = ?", 1)
  end

  def create
    message_attributes = params.permit(:message, :require_confirm, :due_at)
    message_buttons_attributes = params.permit(message_buttons: [:text])
    mentions_attributes = params.permit(mentions: [:slack_id, :name, :profile_picture_url])

    Message.transaction do
      message = Message.new(message_attributes)
      message.user_id = 1 # TODO: Pass the user id parameter from payload user id in JWT.
      message_buttons_attributes[:message_buttons].each do |m|
        message.message_buttons << MessageButton.new(m)
      end
      mentions_attributes[:mentions].each do |m|
        message.mentions << Mention.new(m)
      end
      message.save!
    end

    # TODO: Send Message Button to mention users by Slack DM.

    head :created
  end
end
