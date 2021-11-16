Rails.application.routes.draw do
  #get 'game_genre/game:references'
  #get 'game_genre/genre:references'
  resources :games
  resources :genres
  resources :platforms
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
