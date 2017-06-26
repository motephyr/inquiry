Koala.configure do |config|
#   config.access_token = MY_TOKEN
#   config.app_access_token = MY_APP_ACCESS_TOKEN
  config.app_id = Setting.FACEBOOK_APP_ID
  config.app_secret = Setting.FACEBOOK_APP_SECRET
  config.oauth_callback_url = "/users/auth/facebook/callback"
  # See Koala::Configuration for more options, including details on how to send requests through
  # your own proxy servers.
end