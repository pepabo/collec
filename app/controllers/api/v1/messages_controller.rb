class Api::V1::MessagesController < ApplicationController
  def index
    @messages = User.user_messages(1)
    # TODO: Pass the user id parameter from payload user id in JWT.
  end

  def show
    @message = User.user_message(1, params[:id])
    # TODO: Pass the user id parameter from payload user id in JWT.

    @answers = @message.message_buttons.map do |b|
      {
        text: b.text,
        count: b.message_answers.size,
        percentage: (b.message_answers.size.to_f / @message.message_answers.size) * 100
      }
    end
  end

  def create
    message_params = params.permit(:message, :require_confirm, :due_at)
    message_buttons_params = params.permit(message_buttons: [:text])
    mentions_params = params.permit(mentions: [:slack_id, :name, :profile_picture_url])

    message = Message.new(message_params)
    message.user_id = 1 # TODO: Pass the user id parameter from payload user id in JWT.

    message.message_buttons = message_buttons_params[:message_buttons].map {|m| MessageButton.new(m) }
    message.mentions = mentions_params[:mentions].map {|m| Mention.new(m) }

    Message.transaction do
      begin
        message.save!
      rescue e
        Rails.logger.error e.inspect
      end
    end

    # TODO: Send Message Button to mention users by Slack DM.

    head :created
  end
end
