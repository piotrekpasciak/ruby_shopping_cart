# frozen_string_literal: true

require './specs/spec_helper.rb'

describe Promotions::Actions::PercentageDiscountAction do
  subject { described_class.new(promotion: promotion, total: 80.0) }

  let(:promotion) do
    Promotion.new(
      rule_type:    'total_price_above',
      rule_value:   60,
      action_type:  'percentage_discount',
      action_value: 0.1
    )
  end

  describe '#call' do
    it 'reduces total price by percentage amount' do
      expect(subject.call).to eq 72.0
    end
  end
end
