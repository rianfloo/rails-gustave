Messenger.configure do |config|
  config.verify_token      = ENV['VERIFTOKEN']
  config.page_access_token = ENV['FBTOKEN']
end
