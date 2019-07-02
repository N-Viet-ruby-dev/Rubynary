Rails.application.routes.draw do
  devise_for :users
  root "words#index"
  get "/search", to: "words#index"
  resources :words
end
