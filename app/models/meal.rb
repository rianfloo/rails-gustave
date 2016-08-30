class Meal < ApplicationRecord
  belongs_to :user
  belongs_to :dish
  belongs_to :wine
end
