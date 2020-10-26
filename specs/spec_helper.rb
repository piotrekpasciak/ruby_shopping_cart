# frozen_string_literal: true

require 'bigdecimal'

require './checkout.rb'
require './models/base_model.rb'
require './models/promotion.rb'
require './models/product.rb'
require './promotions/handler.rb'
require './promotions/actions/percentage_discount_action.rb'
require './promotions/actions/product_custom_price_action.rb'
require './promotions/rules/product_presence_rule.rb'
require './promotions/rules/total_price_above_rule.rb'
