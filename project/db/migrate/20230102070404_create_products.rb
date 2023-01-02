class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :pname
      t.text :description
      t.float :price
      t.integer :quantity

      t.timestamps
    end
  end
end
