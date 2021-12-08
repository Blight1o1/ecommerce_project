class GameOrder < ApplicationRecord
  belongs_to :order
  belongs_to :game
end
