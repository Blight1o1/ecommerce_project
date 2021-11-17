class Game < ApplicationRecord
    has_many :game_genres
    has_many :game_platforms
    has_many :genres, through: :game_genres
    has_many :platforms, through: :game_platforms

    validates :name, :price, :score, :rating, presence: true
    validates :price, :score, numericality: true

    paginates_per 20
end
