class Api::V1::MessagesController < ApplicationController
  def index
    @messages = Message.order('id desc').all.page(params[:page]).per(10)
  end

  def show
    @message = Message.find(params[:id])
    @answers = @message.message_buttons.map do |b|
      {
        text: b.text,
        count: b.message_answers.size,
        percentage: (b.message_answers.size.to_f / @message.message_answers.size) * 100
      }
    end
  end

  REMIND_HOUR = 14.freeze
  REMIND_MINUTE = 0.freeze
  def create
    message_params = params.permit(:message, :require_confirm, :due_at, :button_type)
    message_buttons_params = params.permit(message_buttons: [:text])
    mentions_params = params.permit(mentions: [:slack_id, :name, :profile_picture_url])
    message = Message.new(message_params).tap do |ms|
      ms.user_id = current_user.id
      ms.callback_id = Slack::MessageButton.create_identifier
      ms.message_buttons = message_buttons_params[:message_buttons].map do |m|
        MessageButton.new(m).tap do |button|
          button.name = Slack::MessageButton.create_identifier
        end
      end
      ms.mentions = mentions_params[:mentions].map do |m|
        Mention.new(m).tap do |mention|
          mention.text = ms.message
        end
      end
    end

    Message.transaction do
      begin
        message.save!
      rescue => e
        Rails.logger.error e.inspect
        raise e
      end
    end

    message.mentions.each do |m|
      SlackMessageWorker.perform_async m.id
      remind_day = message.due_at - 1.day
      wait = Time.new(remind_day.year, remind_day.month, remind_day.day, REMIND_HOUR, REMIND_MINUTE) - Time.now
      RemindWorker.perform_at(wait, m.id)
    end

    render json: message.to_json(include: %w(message_buttons mentions) ), status: :created
  end
end
