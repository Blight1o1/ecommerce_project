json.extract! game, :id, :name, :description, :price, :score, :rating, :created_at, :updated_at
json.url game_url(game, format: :json)
