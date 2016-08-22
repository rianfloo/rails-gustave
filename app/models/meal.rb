class Meal < ApplicationRecord
  belongs_to :user
  belongs_to :dishe
  belongs_to :wine
end
