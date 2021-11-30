class Order < ApplicationRecord
    has_many :game_orders
    has_many :orders, through: :game_orders
end
