Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, ENV['SLACK_KEY'], ENV['SLACK_SECRET'], scope: 'channels:read,chat:write:bot,chat:write:user,team:read,users:read,identify'
end
