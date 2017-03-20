Cloudinary.config do |config|
  config.cloud_name = ENV['cloudinary_name']
  config.api_key = ENV['cloudinary_id']
  config.api_secret = ENV['cloudinary_secret']
  config.cdn_subdomain = true
end
