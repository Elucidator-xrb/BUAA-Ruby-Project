class Shoppinglist < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :manipulator
end
