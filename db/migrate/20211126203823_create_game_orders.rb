class CreateGameOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :game_orders do |t|
      t.references :game, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.string :address
      t.string :city_province
      t.string :postal_code
      t.decimal :tax_rate
      t.date :order_date
      t.decimal :total

      t.timestamps
    end
  end
end
