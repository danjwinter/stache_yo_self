Rails.application.routes.draw do
  root 'home#homepage'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/privacy', to: 'home#privacy'
  get '/user', to: 'home#show'
end
