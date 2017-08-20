require 'securerandom'

module Slack
  class MessageButton
    def post(params = {})
      client.chat_postMessage(create_options(params))
    end

    def self.create_key
      SecureRandom.hex(8)
    end

    private

    def client
      @client ||= Slack::Web::Client.new
    end

    def create_options(params = {})
      {
        channel: params[:channel],
        text: params[:text],
        attachments: [
          {
            fallback: 'fallback', # TODO: Set fallback
            callback_id: params[:callback_id],
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
          name: message_button[:name],
          text: message_button[:text],
          type: 'button',
        }
      end
    end
  end
end
