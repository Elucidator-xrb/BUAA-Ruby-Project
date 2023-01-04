class AddManipulatorToShoppinglists < ActiveRecord::Migration[7.0]
  def change
    add_reference :shoppinglists, :manipulator, null: false, foreign_key: true
  end
end
