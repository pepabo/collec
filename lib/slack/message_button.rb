require 'securerandom'

module Slack
  class MessageButton
    def client
      @client ||= Slack::Web::Client.new
    end

    def create_options(options = {})
      actions = create_actions(options[:message_buttons])

      {
        channel: options[:channel],
        text: options[:text],
        attachments: [
          {
            fallback: 'fallback', # TODO: Set fallback
            callback_id: 'test', # TODO: Set callback id
            color: '#3AA3E3',
            attachment_type: 'default',
            actions: actions
          }
        ]
      }
    end

    def create_actions(message_buttons = [])
      message_buttons.map do |message_button|
        {
          name: SecureRandom.hex(16),
          text: message_button[:text],
          type: 'button',
        }
      end
    end

    def send(options = {})
      options = create_options(options)
      client.chat_postMessage(options)
    end
  end
end
