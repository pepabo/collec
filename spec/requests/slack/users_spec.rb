require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /api/v1/slack/users" do
    before do
      data = [
        {
          slack_id: "U03XXXXXX",
          name: "testuser",
          real_name: "テスト ユーザー Test User (テス)",
          avatar_url: "http://hoge.io/001.jpg"
        }
      ]
      expect_any_instance_of(Slack::User).to receive(:list).and_return(data)
      get '/api/v1/slack/users'
    end

    it 'response 200' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it 'check json contents' do
      expect(json_parse.first['slack_id']).to eq 'U03XXXXXX'
      expect(json_parse.first['name']).to eq 'testuser'
      expect(json_parse.first['real_name']).to eq 'テスト ユーザー Test User (テス)'
      expect(json_parse.first['avatar_url']).to eq 'http://hoge.io/001.jpg'
    end
  end
end
