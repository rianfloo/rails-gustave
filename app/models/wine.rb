class Wine < ApplicationRecord
  has_many :meals
  before_create :winecolor


  def winecolor
    case self.id_type_vin
    when 1, 7                       # Rouge
      self.wine_color = "#5F192C"
    when 2, 4, 5                    # Blanc
      self.wine_color = "#C86368"
    when 3, 6                       # Rosé
      self.wine_color = "#E4D5A3"
    end
  end

  def picture
    case self.id_type_vin
    when 1, 7                       # Rouge
      "b1.png"
    when 2, 4, 5                    # Blanc
      "b2.png"
    when 3, 6                       # Rosé
      "b3.png"
    end
  end
end
