require 'securerandom'

module Slack
  class MessageButton
    #
    # This method post a message to multiple users with Message Button
    #
    # @option params [String] :callback_id
    # @option params [String] :slack_id
    # @option params [Array<Hash>] :message_buttons
    #
    def bulk_post(params = {})
      params[:mentions].each do |mention|
        post({
          callback_id: params[:callback_id],
          channel: mention[:slack_id],
          text: params[:text],
          message_buttons: params[:message_buttons]
        })
      end
    end

    #
    # This method post a message with Message Button
    #
    # @option params [String] :channel
    # @option params [String] :text
    # @option params [String] :callback_id
    # @option params [Array<Hash>] :message_buttons
    # @see https://github.com/slack-ruby/slack-ruby-client/blob/master/README.md#send-messages
    def post(params = {})
      client.chat_postMessage(create_options(params))
    end

    #
    # This method update a message with Message Button
    #
    # @option params [String] :channel
    # @option params [String] :ts
    # @option params [String] :text
    # @see https://github.com/slack-ruby/slack-ruby-client/blob/master/README.md#send-messages
    def chat_update(params = {})
      Rails.logger.debug(params)
      begin
        response = client.chat_update(params)
        Rails.logger.debug response.inspect
      rescue => e
        Rails.logger.error e.inspect
        raise e
      end

      response
    end

    def disable_previous_message(mention_id)
      mention = Mention.find(mention_id)
      message = mention.message

      message.message = "[updated. please read new message] #{message.message}",

      params = {
        channel: mention.channel,
        ts: mention.ts,
        text: message.message,
        attachments: []
      }

      chat_update(params)
    end

    def update_answered_message(mention_id)
      chat_update(create_update_params(mention_id))
    end

    def create_update_params(mention_id)
      mention = Mention.find(mention_id)
      message = mention.message

      {
        channel: mention.channel,
        ts: mention.ts,
        text: mention.text,
        attachments: [
          {
            fallback: 'fallback', # TODO: Set fallback
            callback_id: message.callback_id,
            color: '#3AA3E3',
            attachment_type: 'default',
            actions: create_actions(effective_buttons(mention_id))
          }
        ]
      }
    end

    #
    # This method create unique identifier for Message Button's callback id or action name
    #
    def self.create_identifier
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

    def effective_buttons(mention_id)
      message_id = Mention.find(mention_id).message_id
      answered_buttons_ids = MessageAnswer.where(mention_id: mention_id).map { |a|
        a.message_button_id
      }
      ::MessageButton.where(message_id: message_id).select { |mb|
        !answered_buttons_ids.include?(mb.id)
      }
    end

  end
end
