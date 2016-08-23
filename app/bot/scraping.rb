# require "rest-client"
require 'nokogiri'
require 'open-uri'
require 'pry-byebug'

# proxies = [
#   "149.202.223.97:8888",
#   "5.249.159.117:666",
#   "108.59.10.129:55555",
#   "216.139.71.163:8118"
# ]

# proxy = proxies.sample
# puts "-- Using proxy #{proxy}"
# response = RestClient::Request.execute(
#   method: :post,
#   url: "http://www.platsnetvins.com/",
#   proxy: "http://#{proxy}",
#   body: {
#   plat: "poulet",
#   senspagination: "+",
# },
# )

# {
#   plat: "poulet",
#   senspagination: "+",
# }
#   plat2: ,
#   rechfiltre: ,
#   partenaire: ,
#   gofiltre: ,
#   coltri: ,
#   senstri: ,
#   fCave: ,
#   code: ,
#   fTypeVinMulti: ,
#   fPays: 1, # France
#   fCepage: 0, # Tous les cépages
#   fBudgetMax: 225, #Tous les prix
#   fNomPlat:
# }


# puts response

# RestClient.proxy = "http://#{proxy}"
# r = RestClient.post('http://www.platsnetvins.com/', {
#   plat: "poulet",
#   senspagination: "+",
#   # plat2: ,
#   # rechfiltre: ,
#   # partenaire: ,
#   # gofiltre: ,
#   # coltri: ,
#   # senstri: ,
#   # fCave: ,
#   # code: ,
#   # fTypeVinMulti: ,
#   # fPays: 1, # France
#   # fCepage: 0, # Tous les cépages
#   # fBudgetMax: 225, #Tous les prix
# })

# puts r
#
doc = File.open(File.dirname(__FILE__) + "/response.html")

html_doc = Nokogiri::HTML.parse(doc)

html_doc.search('.cardresu').each do |vin|
    vin.css('.AccordV').each do |v|
     puts v.text
    end
    puts "----------------"
    vin.css('.TV.AC').each do |c|
     puts c.text
    end
    puts "----------------"
    vin.css('.AL.rdi1').each do |r|
     puts r.text
    end
end
# html_doc.search('.AccordV').each do |vin|
#   puts vin.text
# end

# html_doc.search('.TV.AC').each do |vin|
#   puts vin.text
# end
#  puts "AUTRES INGREIENTS"
# html_doc.search('#fNomPlat option').each do |vin|
#   puts vin.css('value').text
# end
