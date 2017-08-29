class Api::V1::Slack::InteractiveMessagesController < ApplicationController
  # POST parameter: https://api.slack.com/docs/message-buttons
  def create
    message_button = MessageButton.find_by(name: params[:actions].first[:name])
    message = Message.find(message_button[:message_id])
    mention = Mention.find_by(slack_id: params[:user][:id])

    message_answers_params = {
      message_id: message[:id],
      message_button_id: message_button[:id],
      mention_id: mention[:id]
    }

    case message[:button_type]
    when "single"
      MessageAnswer.create_of_single_button(message_answers_params)
    when "multi"
      MessageAnswer.create_of_multi_button(message_answers_params)
    end

    head :created
  end
end
