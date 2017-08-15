class Api::V1::MessagesController < ApplicationController
  def index
    @messages = Message.where("user_id = ?", 1)
  end

  def show
    @message = Message.where("user_id = ? and id = ?", 1, params[:id]).first

    @answers = []
    @message.message_buttons.each do |b|
      answer = {}
      answer[:text] = b.text
      answer[:count] = b.message_answers.size
      answer[:percentage] = (answer[:count].to_f / @message.message_answers.size) * 100
      @answers.push(answer)
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
