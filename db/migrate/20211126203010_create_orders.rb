class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
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
