Rails.application.routes.draw do
  post '/stache_me', to: 'stache_pics#create', formats: {default: :json}
  resource :stache_pics, only: [:create]
end
