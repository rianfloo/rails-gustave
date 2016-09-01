require 'open-uri'

class WineDescription < ServiceBase
  attr_accessor :wine_name

  def initialize(wine_name)
    @wine_name = wine_name
  end

  def run
    google_search(@wine_name)
  end

  private

  def google_search(wine_name)

    keyword = URI.encode(I18n.transliterate(wine_name))
    url_base = "https://cse.google.fr/cse?cx=partner-pub-2369878421197151%3A3543362435&cof=FORID%3A10&ie=UTF-8&sa=+&ad=n9&num=10&siteurl=http%3A%2F%2Fwww.vin-vigne.com&q=vin+"
    url = url_base + keyword

    html_file = open(url)
    html_doc = Nokogiri::HTML(html_file)

    result_google = html_doc.search('.g a').first.attribute('href').value

    html_file = open(result_google)
    html_doc = Nokogiri::HTML(html_file)

    str = html_doc.css('.contenu tr:nth-child(5) table:first-child tr:first-child td:nth-child(2)')

    str.text.gsub(/[\d{5}]/, "").squish.split(".")[0..5]
  end
end
