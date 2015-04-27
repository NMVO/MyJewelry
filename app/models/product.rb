class Product < ActiveRecord::Base
  validates :name, :description, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :name, uniqueness: true
end
