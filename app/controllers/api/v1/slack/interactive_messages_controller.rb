class Api::V1::Slack::InteractiveMessagesController < ApplicationController
  def create
    message_button = MessageButton.where(name: params[:actions].first[:name]).first
    message = Message.find(message_button[:message_id])
    mention = Mention.where(slack_id: params[:user][:id]).first

    message_answers_params = {
      message_id: message[:id],
      message_button_id: message_button[:id],
      mention_id: mention[:id]
    }

    case message[:button_type]
    when "single"
      create_of_single_button(message_answers_params)
    when "multi"
      create_of_multi_button(message_answers_params)
    end

    head :created
  end

  private
  def create_of_single_button(message_answers_params)
    answer = MessageAnswer.where(
      message_id: message_answers_params[:message_id],
      mention_id: message_answers_params[:mention_id],
    ).first

    MessageAnswer.transaction do
      begin
        if answer
          MessageAnswer.find(answer[:id]).update_attributes!(message_button_id: message_answers_params[:message_button_id])
        else
          MessageAnswer.new(message_answers_params).save!
        end
      rescue => e
        Rails.logger.error e.inspect
      end
    end
  end

  def create_of_multi_button(message_answers_params)
    answer = MessageAnswer.where(
      message_id: message_answers_params[:message_id],
      mention_id: message_answers_params[:mention_id],
      message_button_id: message_answers_params[:message_button_id],
    ).first

    MessageAnswer.transaction do
      begin
        if answer
          MessageAnswer.delete(answer[:id])
        else
          MessageAnswer.new(message_answers_params).save!
        end
      rescue => e
        Rails.logger.error e.inspect
      end
    end
  end
end
