Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,  Settings.twitter.access_key,  Settings.twitter.access_secret
end
