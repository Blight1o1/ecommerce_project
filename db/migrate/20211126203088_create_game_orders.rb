class CreateGameOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :game_orders do |t|
      t.references :game, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.string :product
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
