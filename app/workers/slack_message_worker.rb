class SlackMessageWorker
  include Sidekiq::Worker
  sidekiq_options queue: :slack, retry: 5
  def perform(mention_id)
    message_button = Slack::MessageButton.new

    mention = Mention.find(mention_id)
    message = mention.message

    Rails.logger.debug(
      {
        callback_id: message.callback_id,
        channel: mention.slack_id,
        text: message_text(message),
        message_buttons: message.message_buttons
      }
    )
    begin
      response = message_button.post(
        {
          callback_id: message.callback_id,
          channel: mention.slack_id,
          text: message_text(message),
          message_buttons: message.message_buttons
        }
      )
      Rails.logger.debug response.inspect
    rescue => e
      Rails.logger.error e.inspect
      raise e
    end

    mention.channel = response.channel
    mention.ts= response.ts
    mention.save!

    response
  end

  def message_text(message)
    "#{message.message} by @#{message.user[:name]} deadline #{message[:due_at]}"
  end
end
