class Shoppinglist < ApplicationRecord
  has_many :items, dependent: :destroy
end
