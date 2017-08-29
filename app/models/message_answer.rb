class MessageAnswer < ApplicationRecord
  belongs_to :message
  belongs_to :mention
  belongs_to :message_button

  def self.create_of_single_button(message_answers_params)
    answer = MessageAnswer.find_by(
      message_id: message_answers_params[:message_id],
      mention_id: message_answers_params[:mention_id],
    )

    MessageAnswer.transaction do
      begin
        if answer
          if answer[:message_button_id] == message_answers_params[:message_button_id]
            MessageAnswer.delete(answer[:id])
          else
            MessageAnswer.find(answer[:id]).update_attributes!(message_button_id: message_answers_params[:message_button_id])
          end
        else
          MessageAnswer.new(message_answers_params).save!
        end
      rescue => e
        Rails.logger.error e.inspect
      end
    end
  end

  def self.create_of_multi_button(message_answers_params)
    answer = MessageAnswer.find_by(
      message_id: message_answers_params[:message_id],
      mention_id: message_answers_params[:mention_id],
      message_button_id: message_answers_params[:message_button_id],
    )

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
