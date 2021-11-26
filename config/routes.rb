Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  root to: "home#show"
  #resources :games
  resources :genres
  resources :platforms

  resources :games do
    collection do
      get 'search'
    end
  end

  resources :shopping_cart, only: %i[create edit destroy]
  get "/shopping_cart",   to: "shopping_cart#show"

  get "/home",            to: "home#show"
  get "/contact",         to: "contact#show"
  get "/about",           to: "about#show"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
