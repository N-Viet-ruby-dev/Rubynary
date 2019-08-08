# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "sessions",
    omniauth_callbacks: "omniauth_callbacks"
  }
  resources :words
  resources :users
  resources :projects
  resources :project_words
  resources :histories, only: :index
  resources :suggested_words

  get "/search", to: "words#index"
  root "words#index"
end
