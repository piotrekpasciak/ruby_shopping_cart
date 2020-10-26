# frozen_string_literal: true

require './specs/spec_helper.rb'

describe Checkout do
  subject { described_class.new(promotions) }

  let(:promotions) do
    [
      Promotion.new(
        rule_type:    'total_price_above',
        rule_value:   60,
        action_type:  'percentage_discount',
        action_value: 0.1
      )
    ]
  end

  describe '#scan' do
    context 'when there are no scanned products' do
      it 'total returns 0.0' do
        subject.scan('123')

        expect(subject.total).to eq 0.0
      end
    end

    context 'when there are scanned products' do
      it 'total returns sum of scanned products prices' do
        subject.scan('001')
        subject.scan('002')

        expect(subject.total).to eq 54.25
      end
    end

    context 'when there are scanned products and promotion rules are not fulfilled' do
      it 'total returns sum of scanned products prices' do
        subject.scan('001')
        subject.scan('001')

        expect(subject.total).to eq 18.5
      end
    end

    context 'when there are scanned products and promotion rules are fulfilled' do
      let(:promotions) do
        [
          Promotion.new(
            rule_type:    'total_price_above',
            rule_value:   10,
            action_type:  'percentage_discount',
            action_value: 0.1
          )
        ]
      end

      it 'total returns sum of scanned products reduced by promotion discount' do
        subject.scan('001')
        subject.scan('001')

        expect(subject.total).to eq 16.65
      end
    end

    context 'when there are scanned prroduct and 2 promotion rules are fulfilled' do
      let(:promotions) do
        [
          Promotion.new(
            rule_type:    'total_price_above',
            rule_value:   10,
            action_type:  'percentage_discount',
            action_value: 0.1
          ),
          Promotion.new(
            rule_type:    'product_presence',
            rule_value:   2,
            action_type:  'product_custom_price',
            action_value: 8.5,
            product_code: '001'
          )
        ]
      end

      it 'total returns sum of scanned products reduced by both promotions discount' do
        subject.scan('001')
        subject.scan('002')
        subject.scan('001')
        subject.scan('003')

        expect(subject.total).to eq 73.755
      end
    end
  end
end
