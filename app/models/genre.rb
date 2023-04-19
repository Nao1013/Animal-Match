class Genre < ApplicationRecord
  # animal_genre(中間テーブル)とのアソシエーション
  has_many :animal_genres, dependent: :destroy
  has_many :animals, through: :animal_genres, dependent: :destroy
  
end
