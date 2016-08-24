require 'open-uri'

# You just have to call MyService.run("awesome data")
class MyService < ServiceBase
  attr_accessor :useful_variable

  def initialize(useful_variable)
    @useful_variable = useful_variable
  end

  def run
    parsing_xml_from_ingredient()
  end

  private

  def parsing_xml_from_ingredient(xml)
    xml = open(xml)
    vins = Hash.from_xml(xml)
    puts vins["accords_plat"]["accords"]["vin"][0..2]
  end

  def parsing_xml_from_wine(xml)
    xml = open(xml)
    dishes = Hash.from_xml(xml)
    puts dishes["accords_vin"]["accords"]["plat"]
  end
end
