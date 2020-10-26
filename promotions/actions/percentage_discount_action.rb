# frozen_string_literal: true

module Promotions
  module Actions
    class PercentageDiscountAction
      def initialize(promotion:, total:)
        @action_value   = BigDecimal(promotion.action_value, 2)
        @total_in_cents = BigDecimal(total * 100, 0)
      end

      # I could also use money library, but some reviewers get angry when I use
      # library instead of plain code approach in recruitment task
      def call
        new_total_in_cents = total_in_cents - total_in_cents * action_value

        new_total_in_cents / BigDecimal(100)
      end

      private

      attr_reader :action_value, :total_in_cents
    end
  end
end
