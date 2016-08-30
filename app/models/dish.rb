class Dish < ApplicationRecord
  has_many :meals

  def picture
    if photo_url.blank?
      image_google = ImageGoogle.run(name)
      photo_url = image_google
    end
    photo_url
  end
end
