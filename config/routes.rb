Rails.application.routes.draw do
  get 'about/show'
  get 'contact/show'
  resources :games
  resources :genres
  resources :platforms

  get "/contact",         to: "contact#show"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
