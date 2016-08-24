require 'open-uri'

# You just have to call MyService.run("awesome data")
class Gustave < ServiceBase
  attr_accessor :request

  def initialize(request)
    @request = request
  end

  def run
    if @request[:dish]
      # composer l'url vers l'api => url
      # aller chercher le xml => xml (envoyer request[:dish] + params)
      # -> RestClient.post ...
      # parsing_xml_from_ingredient(xml)
    elsif @request[:wine]
      # même traitement pour le wine
    end
  end

  private

  def parsing_xml_from_ingredient(xml)
    vins = Hash.from_xml(xml)
    vins["accords_plat"]["accords"]["vin"][0..2]
  end

  def parsing_xml_from_wine(xml)
    dishes = Hash.from_xml(xml)
    dishes["accords_vin"]["accords"]["plat"]
  end
end

# Gustave.run({ dish: "Poulet" })
# Gustave.run({ wine: "Château Margaux" })
