require 'open-uri'
require 'rails'

# Accord Plat

xml = open("http://www.platsnetvins.com/api-xml/exemple-flux-accords-plat-platsnetvins.xml")

vins = Hash.from_xml(xml)

puts vins["accords_plat"]["accords"]["vin"][0..2]

# Accord Vin

xml = open("http://www.platsnetvins.com/api-xml/exemple-flux-accords-vin-platsnetvins.xml")

dishes = Hash.from_xml(xml)

puts dishes["accords_vin"]["accords"]["plat"]
