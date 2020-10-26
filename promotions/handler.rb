# frozen_string_literal: true

module Promotions
  class Handler
    def initialize(promotion:, cart:, total:)
      @promotion = promotion
      @cart      = cart
      @total     = total
    end

    def call
      return total unless verify_rule?

      new_total = apply_promotion_action

      new_total
    end

    private

    attr_reader :promotion, :cart, :total

    def verify_rule?
      case promotion.rule_type
      when 'product_presence'
        Promotions::Rules::ProductPresenceRule.new(
          promotion: promotion,
          cart:      cart
        ).call
      when 'total_price_above'
        Promotions::Rules::TotalPriceAboveRule.new(
          promotion: promotion,
          total:     total
        ).call
      end
    end

    def apply_promotion_action
      case promotion.action_type
      when 'product_custom_price'
        Promotions::Actions::ProductCustomPriceAction.new(
          promotion: promotion,
          cart:      cart
        ).call
      when 'percentage_discount'
        Promotions::Actions::PercentageDiscountAction.new(
          promotion: promotion,
          total:     total
        ).call
      end
    end
  end
end
