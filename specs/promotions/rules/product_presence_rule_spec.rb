# frozen_string_literal: true

require './specs/spec_helper.rb'

describe Promotions::Rules::ProductPresenceRule do
  subject { described_class.new(promotion: promotion, cart: cart) }

  let(:promotion) do
    Promotion.new(
      rule_type:    'product_presence',
      rule_value:   2,
      action_type:  'product_custom_price',
      action_value: 8.5,
      product_code: '001'
    )
  end

  describe '#call' do
    context 'when cart includes products required by promotion rule' do
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

      it 'returns true' do
        expect(subject.call).to eq true
      end
    end

    context 'when cart does not include products required by promotion rule' do
      let(:cart) do
        [
          Product.new(
            product_code: '001',
            name:         'Red Scarf',
            price:        9.25,
          ),
          Product.new(
            product_code: '002',
            name:         'Silver cufflinks',
            price:        45.00,
          )
        ]
      end

      it 'returns false' do
        expect(subject.call).to eq false
      end
    end
  end
end
