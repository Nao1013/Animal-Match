class Favorite < ApplicationRecord
  
  belongs_to :animal
  belongs_to :reader
  
end
