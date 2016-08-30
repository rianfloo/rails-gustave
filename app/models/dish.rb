class Dish < ApplicationRecord
  has_many :meals
  before_create :dish_picture

  def dish_picture
    dish = self.name
    image_google = ImageGoogle.run(dish)
    self.photo_url = image_google
  end
end
