Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['facebook_app_id'], ENV['facebook_app_secret'], :scope => 'public_profile, user_friends, user_photos', :display => 'popup'
end