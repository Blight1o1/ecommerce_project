class Order < ApplicationRecord
    has_many :game_orders

    validates :product, :quantity, :price, :user_id, presence: true
    validates :price, numericality: true
end
