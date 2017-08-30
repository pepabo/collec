class Api::V1::Slack::InteractiveMessagesController < ApplicationController
  # POST parameter: https://api.slack.com/docs/message-buttons
  def create
    message_button = MessageButton.find_by(name: params[:actions].first[:name])
    message = Message.find(message_button[:message_id])
    mention = Mention.find_by(slack_id: params[:user][:id])

    MessageAnswer.new(
      message_id: message[:id],
      message_button_id: message_button[:id],
      mention_id: mention[:id]
    ).save!

    mention.text = "#{mention.text}. #{message_button.text} が選択されました"
    mention.save!
    MessageButton.update_answered_message(mention.id)

    head :created
  end
end
