class Animal < ApplicationRecord
  
  # 個人側とのアソシエーション(いいね)
  has_many :favorites, dependent: :destroy
  
  def favorited_by?(reader)
    favorites.exists?(reader_id: reader.id)
  end

  # 施設側とのアソシエーション
  belongs_to :facility

  # animal_genre(中間テーブル)とのアソシエーション
  has_many :animal_genres, dependent: :destroy
  has_many :genres, through: :animal_genres, dependent: :destroy

  # コメントのアソシエーション
  has_many :comments, dependent: :destroy
  
   # 説明文バリデーション
  validates :introduct, presence: true, length: {in: 5..10000 }

  # 画像を複数投稿/画像のバリデーション
  has_many_attached :images
  validates :images, presence: true
  validate :validate_image_number
  
  private

  def validate_image_number
    errors.add(:images, 'は3枚までです。') if images.size > 3
  end
  
end
