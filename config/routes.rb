Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  namespace :api do
    resources :wishlists,only: [:create,:destroy]
end
resources :properties
end
