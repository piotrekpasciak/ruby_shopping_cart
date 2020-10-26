# frozen_string_literal: true

module Promotions
  module Rules
    class ProductPresenceRule
      def initialize(promotion:, cart:)
        @product_code = promotion.product_code
        @rule_value   = promotion.rule_value
        @cart         = cart
      end

      def call
        matched_products_count >= rule_value
      end

      private

      attr_reader :product_code, :rule_value, :cart

      def matched_products_count
        cart.select { |product| product.product_code == product_code }.size
      end
    end
  end
end
