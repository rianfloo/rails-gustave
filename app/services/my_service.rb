# You just have to call MyService.run("awesome data")
class MyService < ServiceBase
  attr_accessor :useful_variable

  def initialize(useful_variable)
    @useful_variable = useful_variable
  end

  def run
    parsing_data()
  end

  private

  def parsing_data(doc)
    html_doc = Nokogiri::HTML.parse(doc)

    wines = []

    html_doc.search('.ClsTRPaire, .ClsTR')[0..2].each do |vin|

      wines << {
        appelation: vin.css('.AccordV').text,
        color: vin.css('.TV.AC').text,
        area: vin.css('.AL.rdi1').text
      }
    end
    wines
  end
end
