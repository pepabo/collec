require 'rails_helper'

describe Message, type: :model do
  describe '#calc_percentage' do
    context 'When giving divisible values' do
      before { @result = Message.calc_percentage(1, 2) }
      it { expect(@result).to eq 50 }
    end

    context 'When giving no divisible values' do
      before { @result = Message.calc_percentage(4, 11) }
      it { expect(@result).to eq 36 }
    end
  end
end
