class UniqFacebook < ServiceBase
  attr_accessor :photo_url

  def initialize(photo_url)
    @photo_url = photo_url
  end

  def run
    facebook_uniq_id(@photo_url)
  end

  private

  def facebook_uniq_id(photo_url)
    regex = /\/(\d(.*)g)/
    photo_url.match(regex)[1]
  end
end
