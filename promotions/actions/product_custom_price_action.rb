# frozen_string_literal: true

module Promotions
  module Actions
    class ProductCustomPriceAction
      def initialize(promotion:, cart:)
        @action_value = promotion.action_value
        @product_code = promotion.product_code
        @cart         = cart
      end

      def call
        update_matching_products_price

        cart_product_prices_sum
      end

      private

      attr_reader :action_value, :product_code, :cart

      def update_matching_products_price
        cart.each { |product| product.price = action_value if product.product_code == product_code }
      end

      def cart_product_prices_sum
        cart.sum { |product| product.price }
      end
    end
  end
end
