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
      expect(m['require_confirm']).to eq @message.require_confirm
    end
  end
end
