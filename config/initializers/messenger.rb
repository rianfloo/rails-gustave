Messenger.configure do |config|
  config.verify_token      = '<VERIFY_TOKEN>' #will be used in webhook verifiction
  config.page_access_token = ENV['PROUTPROUT']
end
