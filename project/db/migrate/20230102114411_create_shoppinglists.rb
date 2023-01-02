class CreateShoppinglists < ActiveRecord::Migration[7.0]
  def change
    create_table :shoppinglists do |t|
      t.integer :mtype
      t.float :total

      t.timestamps
    end
  end
end
