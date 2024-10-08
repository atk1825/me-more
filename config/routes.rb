Rails.application.routes.draw do
  devise_for :users
  root to: "users#index"
  resources :users, only: [:index] do
    member do
      get :likes
    end
  end
  resources :posts do
    resources :likes, only: [:create, :destroy]
    member do
      get "problem"
    end
  end
end