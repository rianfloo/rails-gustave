class TokenPicture < ServiceBase
  attr_accessor :token

  def initialize(token)
    @token = token
  end

  def run
    token_to_picture(@token)
  end

  private

  def token_to_picture(token)
    url = "https://graph.facebook.com/v2.6/me?fields=picture&access_token=#{token}"
    r = RestClient.get url
    hash = JSON.parse(r)
    hash["picture"]["data"]["url"]
  end
end
