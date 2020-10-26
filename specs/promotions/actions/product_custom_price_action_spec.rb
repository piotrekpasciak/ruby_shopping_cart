# frozen_string_literal: true

require './specs/spec_helper.rb'

describe Promotions::Actions::ProductCustomPriceAction do
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
      ),
      Product.new(
        product_code: '002',
        name:         'Silver cufflinks',
        price:        45.00,
      )
    ]
  end

  describe '#call' do
    it 'assigns custom price to products in cart' do
      expect(subject.call).to eq 62.0
    end
  end
end
