Rails.application.routes.draw do
  resources :ratings
  resources :rice
  resources :bids, only: [:create]
  devise_for :users

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
 end

  #Pages routes
  get '/farmer', to: 'pages#farmer', as: :farmer
  get '/buyer', to: 'pages#buyer', as: :buyer
  get '/admin', to: 'pages#admin', as: :admin
  get '/inventory', to: 'pages#inventory', as: :inventory

  #Notification routes
  get '/notification', to: 'notifications#index', as: :notification
  root 'pages#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
