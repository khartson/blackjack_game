Rails.application.routes.draw do

  get '/hello', to: 'application#hello_world'

  # sign in routes
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/me', to: 'users#show'

end
