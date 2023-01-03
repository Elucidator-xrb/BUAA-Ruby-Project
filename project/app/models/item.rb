class Item < ApplicationRecord
  validates :quantity, presence: true
  validates :quantity, numericality: {greater_than: 0}
  belongs_to :shoppinglist
  belongs_to :product
end
