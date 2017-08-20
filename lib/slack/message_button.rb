require 'securerandom'

module Slack
  class MessageButton
    def post(params = {})
      client.chat_postMessage(create_options(params))
    end

    private

    def client
      @client ||= Slack::Web::Client.new
    end

    def create_options(params = {})
      {
        channel: options[:channel],
        text: options[:text],
        attachments: [
          {
            fallback: 'fallback', # TODO: Set fallback
            callback_id: 'test', # TODO: Set callback id
            color: '#3AA3E3',
            attachment_type: 'default',
            actions: create_actions(params[:message_buttons])
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
  end
end
