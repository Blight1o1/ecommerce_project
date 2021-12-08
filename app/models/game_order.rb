class GameOrder < ApplicationRecord
  belongs_to :order
  belongs_to :game

  validates :product, :quantity, :price, presence: true
  validates :price, numericality: true
end
