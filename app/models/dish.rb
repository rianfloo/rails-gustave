class Dish < ApplicationRecord
  has_many :meals

  def picture
    if photo_url.blank?
      image_google = ImageGoogle.run(name)
      self.photo_url = image_google
    end
    self.photo_url
  end
end
