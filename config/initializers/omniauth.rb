Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
  :scope => 'email,public_profile,user_photos', image_size: 'normal'
#   :client_options => {
#   :site => 'https://graph.facebook.com/v2.0',
#   :authorize_url => "https://www.facebook.com/v2.0/dialog/oauth"
# },
  # token_params: { parse: :json }
end
