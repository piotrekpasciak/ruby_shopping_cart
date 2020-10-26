# frozen_string_literal: true

class Product < BaseModel
  DATABASE = [
    {
      product_code: '001',
      name:         'Red Scarf',
      price:        9.25,
    },
    {
      product_code: '002',
      name:         'Silver cufflinks',
      price:        45.00,
    },
    {
      product_code: '003',
      name:         'Silk Dress',
      price:        19.95,
    }
  ]

  attr_accessor :product_code, :name, :price

  def initialize(attributes = {})
    self.product_code = attributes[:product_code]
    self.name         = attributes[:name]
    self.price        = attributes[:price]
  end
end
