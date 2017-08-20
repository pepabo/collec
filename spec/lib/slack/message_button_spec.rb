require 'rails_helper'

describe Slack::MessageButton do
  let(:slack) { Slack::MessageButton.new }

  describe '#create_options' do
    context 'when has params values' do
      before do
        @result = slack.send(:create_options, {
                                              callback_id: 'idfuga',
                                              channel: 'UHOGEHOGE',
                                              text: 'dummy text',
                                              message_buttons: [
                                                { name: 'name001', text: 'hoge' },
                                                { name: 'name002', text: 'fuga' },
                                              ]
                                            }
        )
      end

      it { expect(@result[:channel]).to eq 'UHOGEHOGE' }
      it { expect(@result[:text]).to eq 'dummy text' }
      it { expect(@result[:attachments][0][:fallback]).to eq 'fallback' }
      it { expect(@result[:attachments][0][:callback_id]).not_to be_empty }
      it { expect(@result[:attachments][0][:color]).to eq '#3AA3E3' }
      it { expect(@result[:attachments][0][:attachment_type]).to eq 'default' }
    end
  end

  describe '#create_action' do
    context 'when has no values' do
      before { @result = slack.send(:create_actions) }

      it { expect(@result.count).to eq 0 }
      it { expect(@result).to eq [] }
    end

    context 'when has message button values' do
      before do
        @result = slack.send(:create_actions, [
            { name: 'name001', text: 'hoge' },
            { name: 'name002', text: 'fuga' },
          ]
        )
      end

      it { expect(@result.count).to eq 2 }
      it { expect(@result[0][:name]).to eq 'name001' }
      it { expect(@result[0][:text]).to eq 'hoge' }
      it { expect(@result[0][:type]).to eq 'button' }
      it { expect(@result[1][:name]).to eq 'name002' }
      it { expect(@result[1][:name]).not_to be_empty }
      it { expect(@result[1][:text]).to eq 'fuga' }
      it { expect(@result[1][:type]).to eq 'button' }
    end
  end
end
