require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "GET /api/v1/messages" do
    before do
      # "id: 1" because foreign key of message and user
      # are specified by factory test data.
      create(:user, id: 1)
      @message = create(:message)
      create_list(:message, 9)

      get api_v1_messages_path
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

  describe "GET /api/v1/messages/:message_id" do
    before do
      @user_with_messages = create(:user, :with_messages, id: 1)

      create(
        :message_answer,
        message_id: @user_with_messages.messages.first.id,
        mention_id: @user_with_messages.messages.first.mentions.first.id,
        message_button_id: @user_with_messages.messages.first.message_buttons.first.id,
      )

      get api_v1_message_path @user_with_messages.messages.first.id
    end

    it 'response 200' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it 'check json contents' do
      m = json_parse

      expect(m['user_id']).to eq @user_with_messages.id
      expect(m['message']).to eq @user_with_messages.messages.first.message
      expect(m['due_at']).to eq @user_with_messages.messages.first.due_at.as_json
      expect(m['require_confirm']).to eq @user_with_messages.messages.first.require_confirm

      expect(m['report']['answers'].first['text']).to eq @user_with_messages.messages.first.message_buttons.first.text
      expect(m['report']['answers'].first['count']).to eq 1
      expect(m['report']['answers'].first['percentage']).to eq 100

      expect(m['report']['mentioned'].first['name']).to eq @user_with_messages.messages.first.mentions.first.name
      expect(m['report']['mentioned'].first['profile_picture_url']).to eq @user_with_messages.messages.first.mentions.first.profile_picture_url
    end
  end

  describe "POST /api/v1/messages" do
    before do
      create(:user, id: 1)
      expect_any_instance_of(Slack::MessageButton).to receive(:bulk_post).once
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
      expect(@message[:callback_id]).not_to be_empty
      expect(@message_buttons[0][:name]).not_to be_empty
      expect(@message_buttons[0][:text]).to eq 'button01'
      expect(@mentions[0][:slack_id]).to eq 'UHOGEHOGE'
      expect(@mentions[0][:name]).to eq 'fuga'
      expect(@mentions[0][:profile_picture_url]).to eq 'http://hoge.com/fuga.jpg'
    end
  end
end
