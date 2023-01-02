class Item < ApplicationRecord
  belongs_to :shoppinglist
  belongs_to :product
end
