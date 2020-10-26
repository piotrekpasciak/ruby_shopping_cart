# frozen_string_literal: true

require 'bigdecimal'
require './models/base_model.rb'
require './models/product.rb'
require './models/promotion.rb'
require './promotions/handler.rb'
require './promotions/actions/percentage_discount_action.rb'
require './promotions/actions/product_custom_price_action.rb'
require './promotions/rules/product_presence_rule.rb'
require './promotions/rules/total_price_above_rule.rb'

require './checkout.rb'

promotional_rules = Promotion.all
co                = Checkout.new(promotional_rules)

puts 'Basket:'
product_codes = gets.chomp.to_s.delete(' ').split(',')

product_codes.each do |product_code|
  co.scan(product_code)
end

puts "Total price expected: £#{'%.2f' % co.total}"
