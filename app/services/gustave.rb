require 'open-uri'

# You just have to call Gustave.run("awesome data")
class Gustave < ServiceBase
  attr_accessor :request
  attr_accessor :wine_type


  def initialize(request)
    @request = request
  end

  def run
    if @request[:dish]
      dish = @request[:dish]
      wine_type = @request[:wine_type]
      api_url = "http://www.platsnetvins.com/api-xml/j-goillot-n9mvld5bp-accords-plat-xml.php?nomplat=#{dish}&ftypevin=#{wine_type}"
      begin
        # response_xml = RestClient.get api_url #, {:params => {:id => 50, 'foo' => 'bar'}}
        response_xml = RestClient::Request.execute(method: :get, url: api_url, proxy: "http://108.59.10.129:55555")
        parsing_xml_from_ingredient(response_xml)
      rescue
        {}
      end
        # If params
        # api_url + params
    # elsif @request[:wine]
    #   wine = @request[:wine]
    #   # wine_type = ? # DEFINE WITH SYLVAIN
    #   api_url = "http://www.platsnetvins.com/api-xml/j-goillot-n9mvld5bp-accords-vin-xml.php?nomvin=#{wine}&typevin=#{wine_type}"
    #   response_xml = RestClient.get api_url
    #   parsing_xml_from_wine(response_xml)
      # end
    end
  end

  private

  def parsing_xml_from_ingredient(xml)
    vins = Hash.from_xml(xml)
    return [] unless vins["accords_plat"]["accords"]
    return vins["accords_plat"]["accords"]["vin"][0..2]
  end

  def parsing_xml_from_wine(xml)
    dishes = Hash.from_xml(xml)
    dishes["accords_vin"]["accords"]["plat"]
  end
end

# Gustave.run({ dish: "Poulet",  })
# Gustave.run({ wine: "Château Margaux" })
