class Game < ApplicationRecord
    has_many :game_genres
    has_many :game_platforms
    has_many :genres, through: :game_genres
    has_many :platforms, through: :game_platforms
end
