class Api::V1::MessageAnswersController < ApplicationController
  def create
    message_answers_params = params.permit(:message_id, :mention_id, :message_button_id)
    message = Message.find(message_answers_params[:message_id])

    unless message
      raise "message not found"
    end

    # TODO: https://github.com/honeymoon-answer/answer/pull/52
    button_type = 'single'

    my_answers = message.message_answers.find do |answer|
      answer[:mention_id] == message_answers_params[:mention_id]
    end

    if my_answers
      case button_type
      when "single"
        message_answers_params[:id] = my_answers.first[:id]
      when "multi"
        if my_answers.find { |a| a[:message_button_id] == message_answers_params[:message_button_id] }
          message_answers_params[:id] = a[:id]
        end
      else
        raise "unknown button_type"
      end
    end

    MessageAnswer.transaction do
      begin
        MessageAnswer.new(message_answers_params).save!
      rescue => e
        Rails.logger.error e.inspect
      end
    end

    head :created
  end
end
