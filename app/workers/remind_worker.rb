class RemindWorker
  include Sidekiq::Worker
  sidekiq_options queue: :remind, retry: 5
  def perform(mention_id)
    message_button = Slack::MessageButton.new

    mention = Mention.find(mention_id)
    message = mention.message

    begin
      response = message_button.chat_update(
        {
          channel: mention.channel,
          ts: mention.ts,
          text: "[updated. please read new message] #{message.message}",
          attachments: []
        }
      )
    rescue => e
      Rails.logger.error e.inspect
    end

    SlackMessageWorker.perform_async mention_id

    response
  end
end
