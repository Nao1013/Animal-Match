class Genre < ApplicationRecord
  # animal_genre(中間テーブル)とのアソシエーション
  has_many :animal_genres, dependent: :destroy
  has_many :animals, through: :animal_genres, dependent: :destroy
  
  # バリデーション関係
  # attr_accessor :genre_ids
  # validates :genre_ids, presence: true
  
end
