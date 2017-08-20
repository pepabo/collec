require 'rails_helper'

describe Slack::MessageButton do
  let(:slack) { Slack::MessageButton.new }

  describe '#create_action' do
    context 'when has no values' do
      before { @result = slack.send(:create_actions) }

      it { expect(@result.count).to eq 0 }
      it { expect(@result).to eq [] }
    end

    context 'when has message button values' do
      before do
        @result = slack.send(:create_actions, [
            { text: 'hoge' },
            { text: 'fuga' },
          ]
        )
      end

      it { expect(@result.count).to eq 2 }
      it { expect(@result[0][:name]).not_to be_empty }
      it { expect(@result[0][:text]).to eq 'hoge' }
      it { expect(@result[0][:type]).to eq 'button' }
      it { expect(@result[1][:name]).not_to be_empty }
      it { expect(@result[1][:text]).to eq 'fuga' }
      it { expect(@result[1][:type]).to eq 'button' }
    end
  end
end
