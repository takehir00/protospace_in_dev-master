Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'

  resources :prototypes, only: [:index, :new, :create, :edit, :update, :show]
  resources :users, only: [:show, :edit, :update]
end
