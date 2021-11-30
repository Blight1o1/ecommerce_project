class Game < ApplicationRecord
    has_many :game_genres
    has_many :game_platforms
    has_many :game_orders
    has_many :orders, through: :game_orders
    has_many :genres, through: :game_genres
    has_many :platforms, through: :game_platforms

    accepts_nested_attributes_for :game_genres, :game_platforms, allow_destroy: true


    validates :name, :price, :score, :rating, presence: true
    validates :price, :score, numericality: true

    paginates_per 20
end
