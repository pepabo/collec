require 'rails_helper'
describe SlackMessageWorker  do
  before do
    Sidekiq::Testing.inline!
  end

  after do
    Sidekiq::Testing.fake!
  end

  describe 'perform' do
    before do
      # 多分Slackのmockを書くことになる
    end

    it 'sent message to slack' do
      expect_any_instance_of(Dummy).to receive(:send).once
      described_class.perform_async('test')
    end
  end
end
