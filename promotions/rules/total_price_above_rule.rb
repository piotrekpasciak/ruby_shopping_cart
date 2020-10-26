# frozen_string_literal: true

module Promotions
  module Rules
    class TotalPriceAboveRule
      def initialize(promotion:, total:)
        @rule_value = promotion.rule_value
        @total      = total
      end

      def call
        total > rule_value
      end

      private

      attr_reader :rule_value, :total
    end
  end
end
