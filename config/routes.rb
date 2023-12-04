Rails.application.routes.draw do

  resources :users, only: [:update]
  resources :games, only: [:create]

  # game logic routes
  get '/deal', to: 'games#deal'

  # manual auth/sign in routes
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/me', to: 'users#show'
  post '/addcredits', to: 'users#add_credits'


end
