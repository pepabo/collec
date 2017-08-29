require 'rails_helper'

RSpec.describe "InteractiveMessages", type: :request do
  describe "POST /api/v1/slack/interactive-messages/callback button_type single" do
    let!(:user) { create(:user) }
    let!(:message) { create(:message, user: user, button_type: "single") }
    let!(:button) { create(:message_button, message: message) }
    let!(:mention) { create(:mention, message: message) }

    before do
      post "/api/v1/slack/interactive-messages/callback", params:
        {
          actions: [
            name: button.name,
            value: button.text,
            type: 'button',
          ],
          user: {
            id: mention.slack_id,
          },
        }

      @message_answer = MessageAnswer.all
    end

    it 'response 201' do
      expect(response).to be_success
      expect(response.status).to eq 201
    end

    it 'check db registration' do
      expect(@message_answer.size).to eq 1
      expect(@message_answer.first[:message_id]).to eq message.id
      expect(@message_answer.first[:mention_id]).to eq mention.id
      expect(@message_answer.first[:message_button_id]).to eq button.id
    end
  end

  describe "POST /api/v1/slack/interactive-messages/callback button_type single update message answer" do
    let!(:user) { create(:user) }
    let!(:message) { create(:message, user: user, button_type: "single") }
    let!(:buttons) { create_list(:message_button, 2, message: message) }
    let!(:mention) { create(:mention, message: message) }

    before do
      buttons.each do |b|
        post "/api/v1/slack/interactive-messages/callback", params:
          {
            actions: [
              name: b.name,
              value: b.text,
              type: 'button',
            ],
            user: {
              id: mention.slack_id,
            },
          }
      end

      @message_answer = MessageAnswer.all
    end

    it 'response 201' do
      expect(response).to be_success
      expect(response.status).to eq 201
    end

    it 'check db registration' do
      expect(@message_answer.size).to eq 1
      expect(@message_answer.first[:message_id]).to eq message.id
      expect(@message_answer.first[:mention_id]).to eq mention.id
      expect(@message_answer.first[:message_button_id]).to eq buttons.last.id
    end
  end

  describe "POST /api/v1/slack/interactive-messages/callback button_type single delete" do
    let!(:user) { create(:user) }
    let!(:message) { create(:message, user: user, button_type: "single") }
    let!(:button) { create(:message_button, message: message) }
    let!(:mention) { create(:mention, message: message) }

    before do
      2.times do |b|
        post "/api/v1/slack/interactive-messages/callback", params:
          {
            actions: [
              name: button.name,
              value: button.text,
              type: 'button',
            ],
            user: {
              id: mention.slack_id,
            },
          }
      end

      @message_answer = MessageAnswer.all
    end

    it 'response 201' do
      expect(response).to be_success
      expect(response.status).to eq 201
    end

    it 'check db registration' do
      expect(@message_answer.size).to eq 0
    end
  end

  describe "POST /api/v1/slack/interactive-messages/callback button_type multi" do
    let!(:user) { create(:user) }
    let!(:message) { create(:message, user: user, button_type: "multi") }
    let!(:buttons) { create_list(:message_button, 2, message: message) }
    let!(:mention) { create(:mention, message: message) }

    before do
      buttons.each do |b|
        post "/api/v1/slack/interactive-messages/callback", params:
          {
            actions: [
              name: b.name,
              value: b.text,
              type: 'button',
            ],
            user: {
              id: mention.slack_id,
            },
          }
      end

      @message_answer = MessageAnswer.all
    end

    it 'response 201' do
      expect(response).to be_success
      expect(response.status).to eq 201
    end

    it 'check db registration' do
      expect(@message_answer.size).to eq 2
      expect(@message_answer.first[:message_id]).to eq message.id
      expect(@message_answer.first[:mention_id]).to eq mention.id
      expect(@message_answer.first[:message_button_id]).to eq buttons.first.id
    end
  end

  describe "POST /api/v1/slack/interactive-messages/callback button_type multi delete" do
    let!(:user) { create(:user) }
    let!(:message) { create(:message, user: user, button_type: "multi") }
    let!(:button) { create(:message_button, message: message) }
    let!(:mention) { create(:mention, message: message) }

    before do
      2.times do |b|
        post "/api/v1/slack/interactive-messages/callback", params:
          {
            actions: [
              name: button.name,
              value: button.text,
              type: 'button',
            ],
            user: {
              id: mention.slack_id,
            },
          }
      end

      @message_answer = MessageAnswer.all
    end

    it 'response 201' do
      expect(response).to be_success
      expect(response.status).to eq 201
    end

    it 'check db registration' do
      expect(@message_answer.size).to eq 0
    end
  end
end
