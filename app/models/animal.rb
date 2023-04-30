class Animal < ApplicationRecord
  
  # 個人側とのアソシエーション(いいね)
  has_many :favorites, dependent: :destroy
  
  def favorited_by?(reader)
    favorites.exists?(reader_id: reader.id)
  end
  
  # タグとのアソシエーション
  has_many :animal_tags, dependent: :destroy
  has_many :tags, through: :animal_tags
  
  def save_tags(save_animal_tags)
    # 登録されているタグを取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 古いタグを取得（登録されているタグ - フォームから新規に送られてきたタグ）
    old_tags = current_tags - save_animal_tags
    # 新しいタグの取得（フォームから新規に送られてきたタグ - 登録されているタグ）
    new_tags = save_animal_tags - current_tags

    old_tags.each do |old_name|
    # 古いタグを削除
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
    # 新しいタグがテーブルに存在しなければ新規登録
      animal_tag = Tag.find_or_create_by(name: new_name)
      self.tags << animal_tag
    end
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
