Rails.application.routes.draw do
  root 'home#homepage'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/privacy', to: 'home#privacy'
  get '/user', to: 'home#show'
  post '/save_that_stache', to: 'stache_pic#create'
  post '/stache_me', to: 'stache_me#show', formats: {default: :json}
end
