require 'rails_helper'

RSpec.describe "MessageAnswers", type: :request do
  describe "POST /api/v1/slack/interactive-messages/callback" do
    before do
      @user_with_messages = create(:user, :with_messages, id: 1)

      post "/api/v1/slack/interactive-messages/callback", params:
        {
          message_id: @user_with_messages.messages.first.id,
          mention_id: @user_with_messages.messages.first.mentions.first.id,
          message_button_id: @user_with_messages.messages.first.message_buttons.first.id,
        }

      @message_answer = MessageAnswer.first
    end

    it 'response 201' do
      expect(response).to be_success
      expect(response.status).to eq 201
    end

    it 'check db registration' do
      expect(@message_answer[:message_id]).to eq @user_with_messages.messages.first.id
      expect(@message_answer[:mention_id]).to eq @user_with_messages.messages.first.mentions.first.id
      expect(@message_answer[:message_button_id]).to eq @user_with_messages.messages.first.message_buttons.first.id
    end
  end

  describe "POST /api/v1/slack/interactive-messages/callback button_type single update message answer" do
    before do
      @user_with_messages = create(:user, :with_messages, id: 1)

      create(
        :message_answer,
        message_id: @user_with_messages.messages.first.id,
        mention_id: @user_with_messages.messages.first.mentions.first.id,
        message_button_id: @user_with_messages.messages.first.message_buttons[1].id,
      )

      p MessageAnswer.all

      post "/api/v1/slack/interactive-messages/callback", params:
        {
          message_id: @user_with_messages.messages.first.id,
          mention_id: @user_with_messages.messages.first.mentions.first.id,
          message_button_id: @user_with_messages.messages.first.message_buttons.first.id,
        }
      p MessageAnswer.all
      @message_answer = MessageAnswer.first
    end

    it 'response 201' do
      expect(response).to be_success
      expect(response.status).to eq 201
    end

    it 'check db registration' do
      expect(@message_answer[:message_id]).to eq @user_with_messages.messages.first.id
      expect(@message_answer[:mention_id]).to eq @user_with_messages.messages.first.mentions.first.id
      expect(@message_answer[:message_button_id]).to eq @user_with_messages.messages.first.message_buttons.first.id
    end
  end
end
