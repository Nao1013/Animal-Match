class AnimalGenre < ApplicationRecord
  belongs_to :animal
  belongs_to :genre
end
