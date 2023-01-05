class Product < ApplicationRecord
  validates :pname, :description, :price, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0}
  validates :pname, uniqueness: {case_sensitive: true}
  has_many :items, dependent: :destroy
end
