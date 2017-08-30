require 'rails_helper'

RSpec.describe "InteractiveMessages", type: :request do
  describe "POST /api/v1/slack/interactive-messages/callback" do
    let!(:user) { create(:user) }
    let!(:message) { create(:message, user: user) }
    let!(:button) { create(:message_button, message: message) }
    let!(:mention) { create(:mention, message: message) }

    before do
      WebMock.stub_request(:post, "https://slack.com/api/chat.update").to_return(
        body: File.read("#{Rails.root}/test/fixtures/slack_chat_update_response.json"),
        status: 200,
        headers: { 'Content-Type' =>  'application/json' })

      post "/api/v1/slack/interactive-messages/callback", params:
        {
          payload: {
            actions: [
              {
                name: button.name,
                value: button.text,
                type: 'button',
              },
            ],
            user: {
              id: mention.slack_id,
            },
          }.to_json
        }
      @message_answer = MessageAnswer.first
    end

    it 'response 201' do
      expect(response).to be_success
      expect(response.status).to eq 201
    end

    it 'check db registration' do
      expect(@message_answer[:message_id]).to eq message.id
      expect(@message_answer[:mention_id]).to eq mention.id
      expect(@message_answer[:message_button_id]).to eq button.id
    end
  end
end
