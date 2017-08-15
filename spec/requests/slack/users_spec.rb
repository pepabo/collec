require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /api/v1/slack/users" do
    before do
      get '/api/v1/slack/users'
    end

    it 'response 200' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it 'check json contents' do
      expect(json_parse.first['slack_id']).to eq 'UHOGE'
      expect(json_parse.first['name']).to eq 'hypermkt'
      expect(json_parse.first['avatar_url']).to eq 'http://hoge.io/001.jpg'
    end
  end
end
