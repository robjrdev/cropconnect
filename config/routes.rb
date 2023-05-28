Rails.application.routes.draw do
  resources :ratings
  resources :rice
  resources :bids, only: [:create]
  devise_for :users

  get '/farmer', to: 'pages#farmer', as: :farmer
  get '/buyer', to: 'pages#buyer', as: :buyer
  get '/dashboard', to: 'pages#dashboard', as: :dashboard
  root 'pages#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
