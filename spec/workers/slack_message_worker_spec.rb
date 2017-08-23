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
      create(:user, id: 1)
      message = create(:message)
      create(:message_button, mention_id: message.id)
      @mention = create(:mention, mention_id: message.id)
      expect_any_instance_of(Slack::MessageButton).to receive(:post).once

      worker = SlackMessageWorker.new
      worker.perform(mention)
    end
  end
end
