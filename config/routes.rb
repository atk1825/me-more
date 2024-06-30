Rails.application.routes.draw do
  devise_for :users
  root to: "my_pages#index"
  resources :my_pages
end
