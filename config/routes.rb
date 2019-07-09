# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root "words#index"
  get "/search", to: "words#index"
  resources :words
  resources :projects
end
