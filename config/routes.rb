Rails.application.routes.draw do
  devise_for :users
  root to: "users#index"
  resources :users, only: [:index]
  resources :posts do
    resources :likes, only: [:create, :destroy]
  end
end