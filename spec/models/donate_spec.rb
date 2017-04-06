require 'rails_helper'

describe Donate do
  describe 'has aasm_state' do
    let(:donate) { Donate.new }

    it 'when init' do
      expect(donate).to transition_from(:unpaid).to(:paid).on_event(:pay)
      expect(donate).to transition_from(:paid).to(:unrefunded).on_event(:refund)
      expect(donate).to transition_from(:unrefunded).to(:refunded).on_event(:confirm_refund)
    end
  end


  describe '#donate' do
    context 'when donate' do
      pending "add some examples to (or delete) #{__FILE__}"
    end
  end
end
