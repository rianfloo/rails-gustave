class GetMessengerId < ServiceBase
  attr_accessor :messenger_id

  def initialize(messenger_id)
    @messenger_id = messenger_id
  end

  def run
    facebook_hash(@messenger_id)
  end

  private

   def facebook_hash(messenger_id)
    user_facebook = messenger_id
    url  = "https://graph.facebook.com/v2.6/#{user_facebook}?access_token=EAAY3zbgCSw8BAOaChwA9uKnBW0AOaqMfv2MFNkNMVtfR2yJvrx87axzXW4ImgDmjgtHAkyBrfUQIZBxgNDEK3jix3oQg6W810iHe0SUjVUbZB9gQXt2in3RRlmWvzU4NCEDMJbYl8hy7qlOHR0ny3chtVBCaTnNnBxbZBFzfQZDZD"
    r = RestClient.get url
    hash = JSON.parse(r)
    hash.except!("timezone", "gender", "locale")
  end
end
