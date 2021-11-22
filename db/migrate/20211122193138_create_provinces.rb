class CreateProvinces < ActiveRecord::Migration[6.1]
  def change
    create_table :provinces do |t|
      t.string :name
      t.string :abbreviation
      t.decimal :hst
      t.decimal :pst
      t.decimal :gst
      t.decimal :total_tax

      t.timestamps
    end
  end
end
