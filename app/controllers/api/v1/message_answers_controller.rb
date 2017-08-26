class Api::V1::MessageAnswersController < ApplicationController
  def create
    message_answers_params = params.permit(:message_id, :mention_id, :message_button_id)

    answer = MessageAnswer.where(
      message_id: message_answers_params[:message_id],
      mention_id: message_answers_params[:mention_id],
    ).first

    if answer
      MessageAnswer.find(answer[:id]).update_attributes!(message_button_id: message_answers_params[:message_button_id])
    else
      MessageAnswer.new(message_answers_params).save!
    end

    head :created
  end
end
