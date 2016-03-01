Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, ENV['SLACK_KEY'], ENV['SLACK_SECRET'], scope: 'client'
end
