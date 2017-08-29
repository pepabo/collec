require 'rails_helper'
require 'webmock/rspec'

describe RemindWorker  do
  before do
    Sidekiq::Testing.inline!
  end

  after do
    Sidekiq::Testing.fake!
  end

  describe 'perform' do
    before do
      user_with_messages = create(:user, :with_messages)

      WebMock.stub_request(:post, "https://slack.com/api/chat.postMessage").to_return(
        body: File.read("#{Rails.root}/test/fixtures/slack_chat_post_response.json"),
        status: 200,
        headers: { 'Content-Type' =>  'application/json' })

      @mention_id = user_with_messages.messages.first.mentions.first.id
      SlackMessageWorker.perform_async(@mention_id)

      WebMock.stub_request(:post, "https://slack.com/api/chat.update").to_return(
        body: File.read("#{Rails.root}/test/fixtures/slack_chat_update_response.json"),
        status: 200,
        headers: { 'Content-Type' =>  'application/json' })
    end

    it 'proceeding slack job' do
      expect(subject).to be_processed_in :remind
    end

    it 'update previous message' do
      res = subject.perform(@mention_id)
      expect(res['channel']).to eq 'DXXXXXXXX'
      expect(res['ts']).to eq '1503499924.000735'
      expect(res['text']).to eq '[remind] Hello World'
    end

    it 'enqueue DM send job' do
      subject.perform(@mention_id)
    end
  end
end
