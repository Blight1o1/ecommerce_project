class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.decimal :score
      t.string :rating

      t.timestamps
    end
  end
end
