class SlackMessageWorker
  include Sidekiq::Worker
  sidekiq_options queue: :slack, retry: 5
  def perform(mention_id)
    message_button = Slack::MessageButton.new

    mention = Mention.find(mention_id)
    # 回答済みの場合は送信しない
    return if mention.message_answers.size > 0

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
    due_at = Time.parse(message[:due_at].to_s).strftime("%F %R")

    <<-EOF
Hey! You've got a message from @#{message.user[:name]}. Please answer the question blow by #{due_at} !
---
#{message.message}
    EOF
  end
end
