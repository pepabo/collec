require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "GET /api/v1/messages" do
    before do
      create(:slack_user_with_messages)
      get '/api/v1/messages', headers: { HTTP_ACCEPT: 'application/json', CONTENT_TYPE: 'application/json' }
    end

    it 'response 200' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it 'return all messages' do
      result = JSON.parse(response.body)
      expect(result.count).to eq 10
    end
  end
end
