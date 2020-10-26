# frozen_string_literal: true

class Checkout
  attr_accessor :total

  def initialize(promotions)
    self.total  = 0.0
    @promotions = promotions
    @cart       = []
  end

  def scan(item_code)
    add_product_to_cart(item_code)

    # We need to apply product_custom_price pomotions first to
    # ensure that our promotions will work in predictable manner
    product_custom_price_promotions.each do |promotion|
      self.total = promotion.apply(cart, total)
    end

    non_product_custom_price_promotions.each do |promotion|
      self.total = promotion.apply(cart, total)
    end
  end

  private

  attr_reader :promotions, :cart

  def add_product_to_cart(item_code)
    product = Product.find_by(:product_code, item_code)

    if product
      cart << product

      self.total += product.price
    end
  end

  def product_custom_price_promotions
    promotions.select { |promotion| promotion.action_type == 'product_custom_price' }
  end

  def non_product_custom_price_promotions
    promotions.select { |promotion| promotion.action_type != 'product_custom_price' }
  end
end
