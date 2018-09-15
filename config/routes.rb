Rails.application.routes.draw do
  get '/', to: 'health#check'
  post '/stache_me', to: 'stache_pics#create', formats: {default: :json}
  resource :stache_pics, only: [:create]
  get '/slack_callback', to: 'slack_apps#create'
end
