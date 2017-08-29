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
    let!(:user) { create(:user) }
    let!(:message) { create(:message, user: user) }
    let!(:mention) { create(:mention, message: message) }

    before do
      WebMock.stub_request(:post, "https://slack.com/api/chat.postMessage").to_return(
        body: File.read("#{Rails.root}/test/fixtures/slack_chat_post_response.json"),
        status: 200,
        headers: { 'Content-Type' =>  'application/json' })
    end

    it 'proceeding slack job' do
      expect(SlackMessageWorker).to be_processed_in :slack
    end

    it 'dm normally sended.' do
      res = subject.perform(mention.id)
      expect(res['channel']).to eq 'DXXXXXXXX'
      expect(res['message']['text']).to eq 'Hello World'
      expect(res['message']['username']).to eq 'answer'
      expect(res['message']['bot_id']).to eq 'B11111111'
      expect(res['message']['type']).to eq 'message'
      expect(res['message']['subtype']).to eq 'bot_message'
    end
  end
end
