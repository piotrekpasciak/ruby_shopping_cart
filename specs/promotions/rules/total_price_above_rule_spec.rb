# frozen_string_literal: true

require './specs/spec_helper.rb'

describe Promotions::Rules::TotalPriceAboveRule do
  subject { described_class.new(promotion: promotion, total: total) }

  let(:promotion) do
    Promotion.new(
      rule_type:    'total_price_above',
      rule_value:   60,
      action_type:  'percentage_discount',
      action_value: 0.1
    )
  end

  describe '#call' do
    context 'when total amount is above rule_value' do
      let(:total) { 80.0 }

      it 'returns true' do
        expect(subject.call).to eq true
      end
    end

    context 'when total amount is below rule_value' do
      let(:total) { 10.0 }

      it 'returns false' do
        expect(subject.call).to eq false
      end
    end
  end
end
