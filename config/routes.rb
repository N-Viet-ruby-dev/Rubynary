# frozen_string_literal: true

Rails.application.routes.draw do
  resources :words
  devise_for :users
  get "/search", to: "words#index"
  root "words#index"
end
