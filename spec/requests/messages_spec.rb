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
      create(:mention, id: 1, slack_id: "ABCDEFG01", name: "user01", profile_picture_url: "http://hoge/user01.jpg")
      create(:mention, id: 2, slack_id: "ABCDEFG02", name: "user02", profile_picture_url: "http://hoge/user02.jpg")
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

      expect(m['report']['answers'][0]['text']).to eq 'label1'
      expect(m['report']['answers'][0]['count']).to eq 1
      expect(m['report']['answers'][0]['percentage']).to eq 50

      expect(m['report']['mentioned'][0]['name']).to eq 'user01'
      expect(m['report']['mentioned'][0]['profile_picture_url']).to eq 'http://hoge/user01.jpg'
    end
  end

  describe "POST /api/v1/messages" do
    before do
      create(:user, id: 1)
      post api_v1_messages_path, params:
                                 {
                                   message: 'hoge',
                                   require_confirm: 0,
                                   due_at: '2017-08-15 10:00:00',
                                   message_buttons: [
                                     { text: 'button01' },
                                   ],
                                   mentions: [
                                     { slack_id: 'UHOGEHOGE', name: 'fuga', profile_picture_url: 'http://hoge.com/fuga.jpg' }
                                   ]
                                 }

      @message = Message.first
      @message_buttons = MessageButton.where('message_id = ?', @message.id)
      @mentions = Mention.where('message_id = ?', @message.id)
    end

    it 'response 201' do
      expect(response).to be_success
      expect(response.status).to eq 201
    end

    it 'check db registration' do
      expect(@message[:message]).to eq 'hoge'
      expect(@message[:require_confirm]).to eq false
      expect(@message[:due_at]).to eq '2017-08-15 10:00:00'
      expect(@message_buttons[0][:text]).to eq 'button01'
      expect(@mentions[0][:slack_id]).to eq 'UHOGEHOGE'
      expect(@mentions[0][:name]).to eq 'fuga'
      expect(@mentions[0][:profile_picture_url]).to eq 'http://hoge.com/fuga.jpg'
    end
  end
end
