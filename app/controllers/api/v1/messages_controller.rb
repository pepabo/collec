class Api::V1::MessagesController < ApiController
  def index
    @messages = Message.where("user_id = ?", 1)
  end

  def create
    message_params = params.permit(:message, :require_confirm, :due_at)
    message_buttons_params = params.permit(message_buttons: [:text])
    mentions_params = params.permit(mentions: [:slack_id, :name, :profile_picture_url])

    message = Message.new(message_params)
    message.user_id = 1 # TODO: Pass the user id parameter from session
    message.callback_id = Slack::MessageButton.create_identifier

    message.message_buttons = message_buttons_params[:message_buttons].map do |m|
      button = MessageButton.new(m)
      button.name = Slack::MessageButton.create_identifier
      button
    end
    message.mentions = mentions_params[:mentions].map {|m| Mention.new(m) }

    Message.transaction do
      begin
        message.save!
      rescue => e
        Rails.logger.error e.inspect
      end
    end

    message_button = Slack::MessageButton.new
    begin
      message_button.bulk_post(
        {
          mentions: mentions_params[:mentions],
          message_buttons: message.message_buttons,
          callback_id: message.callback_id,
          text: message_params[:message]
        }
      )
    rescue => e
      Rails.logger.error e.inspect
    end

    head :created
  end
end
