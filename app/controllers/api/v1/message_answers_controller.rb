class Api::V1::MessageAnswersController < ApplicationController
  def create
    message_answers_params = params.permit(:message_id, :mention_id, :message_button_id)
    # TODO: https://github.com/honeymoon-answer/answer/pull/52
    #message = Message.find(message_answers_params[:message_id])
    #case message[:button_type]
    case "single"
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
