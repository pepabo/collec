require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "GET /api/v1/messages" do
    let!(:user) { create(:user) }
    let!(:message) { create(:message, user: user) }
    let(:parse_response) { json_parse.first }

    before do
      get api_v1_messages_path
    end

    it 'response success', autodoc: true do
      expect(response).to be_success
      expect(response.status).to eq 200
      expect(json_parse.count).to eq 1
      expect(parse_response['user_id']).to eq user.id
      expect(parse_response['message']).to eq message.message
      expect(parse_response['due_at']).to eq message.due_at.as_json
      expect(parse_response['require_confirm']).to eq message.require_confirm
    end
  end

  describe "GET /api/v1/messages/:message_id" do
    let!(:user) { create(:user) }
    let!(:message) { create(:message, user: user) }
    let!(:button) { create(:message_button, message: message) }
    let!(:mention) { create(:mention, message: message) }
    let!(:answer) { create(:message_answer, message: message, message_button: button, mention: mention) }
    let(:parse_response) { json_parse }

    before do
      get api_v1_message_path message.id
    end

    it 'response success', autodoc: true do
      expect(response).to be_success
      expect(response.status).to eq 200

      expect(parse_response['user_id']).to eq user.id
      expect(parse_response['message']).to eq message.message
      expect(parse_response['due_at']).to eq message.due_at.as_json
      expect(parse_response['require_confirm']).to eq message.require_confirm

      expect(parse_response['report']['answers'].first['text']).to eq button.text
      expect(parse_response['report']['answers'].first['count']).to eq 1
      expect(parse_response['report']['answers'].first['percentage']).to eq 100

      expect(parse_response['report']['mentioned'].first['name']).to eq mention.name
      expect(parse_response['report']['mentioned'].first['profile_picture_url']).to eq mention.profile_picture_url
    end
  end

  describe "POST /api/v1/messages" do
    let(:parse_response) { json_parse }

    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(create(:user))
      params = {
         message: 'hoge',
         require_confirm: 0,
         due_at: '2017-08-15 10:00:00',
         button_type: 'single',
         message_buttons: [
           { text: 'button01' },
         ],
         mentions: [
           { slack_id: 'UHOGEHOGE', name: 'fuga', profile_picture_url: 'http://hoge.com/fuga.jpg' }
         ]
      }

      post api_v1_messages_path, params: params
    end

    it 'resposne created', autodoc: true do
      expect(response).to be_success
      expect(response.status).to eq 201

      expect(parse_response["message"]).to eq 'hoge'
      expect(parse_response["require_confirm"]).to eq false
      expect(Time.new(parse_response["due_at"])).to eq Time.new('2017-08-15 10:00:00')
      expect(parse_response["button_type"]).to eq 'single'
      expect(parse_response["callback_id"]).not_to be_empty

      expect(parse_response["message_buttons"].first["name"]).not_to be_empty
      expect(parse_response["message_buttons"].first["text"]).to eq 'button01'

      expect(parse_response["mentions"].first["slack_id"]).to eq 'UHOGEHOGE'
      expect(parse_response["mentions"].first["name"]).to eq 'fuga'
      expect(parse_response["mentions"].first["profile_picture_url"]).to eq 'http://hoge.com/fuga.jpg'
    end

    it 'enqueue sidekiq' do
      expect(SlackMessageWorker.jobs.size).to eq 1
      expect(SlackMessageWorker.jobs.first['args'].first).to eq parse_response["mentions"].first["id"]
    end

    it 'enqueue remind job' do
      expect(RemindWorker.jobs.size).to eq 1
      expect(RemindWorker.jobs.first['args'].first).to eq parse_response["mentions"].first["id"]
    end
  end
end
