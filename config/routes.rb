Rails.application.routes.draw do
  get 'invoice/index'
  get 'invoice/show'
  get 'orders/index'
  get 'orders/show'
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

  resources :shopping_cart#, only: %i[create edit destroy]
  get "/shopping_cart",   to: "shopping_cart#index"
  post "/shopping_cart/:id",   to: "shopping_cart#add_to_cart"

  resources :orders#, only: %i[create edit destroy]


  scope "/checkout" do
    post "create",  to: "checkout#create",  as: "checkout_create"
    get  "success", to: "checkout#success", as: "checkout_success"
    get  "cancel",  to: "checkout#cancel",  as: "checkout_cancel"
  end

  get "/home",            to: "home#show"
  get "/contact",         to: "contact#show"
  get "/about",           to: "about#show"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
