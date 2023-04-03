class Genre < ApplicationRecord
  # animalとのアソシエーション
  has_many :animals, dependent: :destroy
end
