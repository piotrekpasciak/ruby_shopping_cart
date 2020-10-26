# frozen_string_literal: true

class Promotion < BaseModel
  DATABASE = [
    {
      rule_type:    'total_price_above',
      rule_value:   60,
      action_type:  'percentage_discount',
      action_value: 0.1
    },
    {
      rule_type:    'product_presence',
      rule_value:   2,
      action_type:  'product_custom_price',
      action_value: 8.5,
      product_code: '001'
    }
  ]

  attr_accessor :rule_type, :product_code, :rule_value, :action_type, :action_value

  def initialize(attributes = {})
    self.rule_type             = attributes[:rule_type]
    self.product_code          = attributes[:product_code]
    self.rule_value            = attributes[:rule_value]
    self.action_type           = attributes[:action_type]
    self.action_value          = attributes[:action_value]
  end

  def apply(cart, total)
    new_total = Promotions::Handler.new(
      promotion: self,
      cart:      cart,
      total:     total
    ).call

    new_total
  end
end
