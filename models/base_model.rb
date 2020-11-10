# frozen_string_literal: true

class BaseModel
  def self.all
    self::DATABASE.map { |attributes| self.new(attributes) }
  end

  def self.find_by(key, value)
    attributes = self::DATABASE.find { |object| object[key] == value }
    self.new(attributes) unless attributes.nil?
  end
end
