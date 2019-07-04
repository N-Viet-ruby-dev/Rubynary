# frozen_string_literal: true

Rails.application.routes.draw do
  resources :words, only: :index
  devise_for :users
  get :search, controller: :words
  root "words#index"
end
