class SlackMessageWorker
  include Sidekiq::Worker
  sidekiq_options queue: :slack, retry: 5
  def perform(mention_id)
    message_button = Slack::MessageButton.new

    mention = Mention.find(mention_id)
    message = Message.find(mention.message_id)
    begin
      message_button.post(
        {
          callback_id: message.callback_id,
          channel: mention.slack_id,
          text: message.message,
          message_buttons: message.message_buttons
        }
      )
    rescue => e
      Rails.logger.error e.inspect
    end
  end
end
