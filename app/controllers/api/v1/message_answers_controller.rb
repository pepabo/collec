class Api::V1::MessageAnswersController < ApplicationController
  def create
    message_answers_params = params.permit(:message_id, :mention_id, :message_button_id)

    #message = Message.find(message_answers_params[:message_id])

    message_answer = MessageAnswer.new(message_answers_params)
    # TODO: https://github.com/honeymoon-answer/answer/pull/52
    #case message[:button_type]
    answers = nil
    case 'single'
    when "single"
      answers = MessageAnswer.where(
        message_id: message_answers_params[:message_id],
        mention_id: message_answers_params[:mention_id],
      )
    when "multi"
      answers = MessageAnswer.where(
        message_id: message_answers_params[:message_id],
        mention_id: message_answers_params[:mention_id],
        message_button_id: message_answers_params[:message_button_id]
      )
    end

    MessageAnswer.transaction do
      begin
        if answers.empty?
          message_answer.save!
        else
          message_answer.update!
        end
        p MessageAnswer.all.first
      rescue => e
        Rails.logger.error e.inspect
      end
    end

    head :created
  end
end
