require 'open-uri'

class ImageGoogle < ServiceBase
  attr_accessor :dish

  def initialize(dish)
    @dish = dish
  end

  def run
    keyword_to_picture(@dish)
  end

  private

  def keyword_to_picture(dish)
    url = "https://www.google.fr/search?q=#{dish}%2Bfood&hl=fr&tbm=isch&tbs=itp:photo,isz:l"
    html_file = open(url)
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.images_table img').first["src"]
  end
end
