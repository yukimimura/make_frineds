Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  root to: 'home#top'

  devise_for :users

  resources :users do
    member do
      get :followings
      get :followers
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :posts
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index]
end
