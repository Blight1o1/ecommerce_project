class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :product
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
