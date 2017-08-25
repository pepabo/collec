class Api::V1::MessageAnswersController < ApplicationController
  def create
    message_answers_params = params.permit(:message_id, :mention_id, :message_button_id)

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
