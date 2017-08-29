class RemindWorker
  include Sidekiq::Worker
  sidekiq_options queue: :remind, retry: 5
  def perform(mention_id)
    message_button = Slack::MessageButton.new

    mention = Mention.find(mention_id)
    message = mention.message

    Rails.logger.debug(
      {
        channel: mention.channel,
        ts: mention.ts,
        text: "[updated. please read new message] #{message.message}"
      }
    )
    begin
      response = message_button.chat_update(
        {
          channel: mention.channel,
          ts: mention.ts,
          text: "[updated. please read new message] #{message.message}",
          attachments: []
        }
      )
      Rails.logger.debug response.inspect
    rescue => e
      Rails.logger.error e.inspect
      raise e
    end

    SlackMessageWorker.perform_async mention_id

    response
  end
end
