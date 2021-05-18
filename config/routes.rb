Rails.application.routes.draw do
  get 'rails/g'
  get 'rails/controller'
  get 'rails/attendances'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :attendances
  resources :events
  resources :users
  resources :teams, only: [:index]
  resources :contacts, only: [:index]
  root 'events#index'
end
