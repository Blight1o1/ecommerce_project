class Order < ApplicationRecord
    has_many :game_orders
    has_many :orders, through: :game_orders

    validates :product, :quantity, :price, :user_id, presence: true
    validates :price, numericality: true
end
