# frozen_string_literal: true

class BaseModel
  def self.all
    self::DATABASE.map { |promotion| Promotion.new(promotion) }
  end

  def self.find_by(key, value)
    product_attributes = self::DATABASE.find { |product| product[key] == value }
    Product.new(product_attributes) unless product_attributes.nil?
  end
end
