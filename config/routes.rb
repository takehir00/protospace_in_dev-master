Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'

  resources :prototypes, only: [:index, :new, :create, :edit, :update, :show] do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end


  resources :users, only: [:show, :edit, :update]

end
