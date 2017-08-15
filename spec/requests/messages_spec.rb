require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "GET /api/v1/messages" do
    before do
      # "id: 1" because foreign key of message and user
      # are specified by factory test data.
      create(:user, id: 1)
      @message = create(:message)
      create_list(:message, 9)
      get '/api/v1/messages'
    end

    it 'response 200' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it 'check json contents' do
      expect(json_parse.count).to eq 10
      m = json_parse.first
      expect(m['user_id']).to eq @message.user_id
      expect(m['message']).to eq @message.message
      expect(m['due_at']).to eq @message.due_at.as_json
      expect(m['require_confirm']).to eq @message.require_confirm
    end
  end

  describe "GET /api/v1/messages/:id" do
    before do
      create(:user, id: 1)
      @message = create(:message, id: 1)
      create(:mention, id: 1, slack_id: "ABCDEFG01")
      create(:mention, id: 2, slack_id: "ABCDEFG02")
      create(:message_button, id: 1, name: "name1", text: "label1")
      create(:message_button, id: 2, name: "name2", text: "label2")
      create(:message_answer, id: 1, mention_id: 1, message_button_id: 1)
      create(:message_answer, id: 2, mention_id: 2, message_button_id: 2)

      get '/api/v1/messages/1'
    end

    it 'response 200' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it 'check json contents' do
      m = json_parse
      expect(m['user_id']).to eq @message.user_id
      expect(m['message']).to eq @message.message
      expect(m['due_at']).to eq @message.due_at.as_json
      expect(m['require_confirm']).to eq @message.require_confirm
    end
  end
end
