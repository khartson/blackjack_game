Rails.application.routes.draw do

  resources :users, only: [:update]

  # manual auth/sign in routes
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/me', to: 'users#show'
  post '/addcredits', to: 'users#add_credits'

end
