require 'rails_helper'
require 'webmock/rspec'

describe SlackMessageWorker  do
  before do
    Sidekiq::Testing.inline!
  end

  after do
    Sidekiq::Testing.fake!
  end

  describe 'perform' do
    before do
      user_with_messages = create(:user, :with_messages, id: 1)

      WebMock.stub_request(:post, "https://slack.com/api/chat.postMessage").to_return(
        body: File.read("#{Rails.root}/test/fixtures/slack_chat_post_response.json"),
        status: 200,
        headers: { 'Content-Type' =>  'application/json' })

      @mention_id = user_with_messages.messages.first.mentions.first.id
    end

    it 'dm normally sended.' do
      res = subject.perform(@mention_id)
      expect(res['channel']).to eq 'DXXXXXXXX'
      expect(res['message']['text']).to eq 'Hello World'
      expect(res['message']['username']).to eq 'answer'
      expect(res['message']['bot_id']).to eq 'B11111111'
      expect(res['message']['type']).to eq 'message'
      expect(res['message']['subtype']).to eq 'bot_message'
    end
  end
end
