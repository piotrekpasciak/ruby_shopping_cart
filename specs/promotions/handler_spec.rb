# frozen_string_literal: true

require './specs/spec_helper.rb'

describe Promotions::Handler do
  subject { described_class.new(promotion: promotion, cart: cart, total: 10.0) }

  describe '#call' do
    context 'when product_presence promotion with percentage_discount provided' do
      let(:promotion) do
        Promotion.new(
          rule_type:    'total_price_above',
          rule_value:   2,
          action_type:  'percentage_discount',
          action_value: 0.1,
          product_code: '001'
        )
      end
      let(:cart) do
        [
          Product.new(
            product_code: '001',
            name:         'Red Scarf',
            price:        9.25,
          ),
          Product.new(
            product_code: '001',
            name:         'Red Scarf',
            price:        9.25,
          )
        ]
      end

      it 'calls ProductPresenceRule, PercentageDiscountAction and returns new total price' do
        expect(subject.call).to eq 9.0
      end
    end
  end
end
