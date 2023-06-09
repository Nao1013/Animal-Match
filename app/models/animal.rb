class Animal < ApplicationRecord

  # 個人側とのアソシエーション(いいね)
  has_many :favorites, dependent: :destroy

  def favorited_by?(reader)
    favorites.exists?(reader_id: reader.id)
  end

 # 施設側とのアソシエーション
  belongs_to :facility

  # 退会した施設の投稿を表示しない
  def active_facility?
    facility.active? # Facilityモデルにactive?メソッドが必要です
  end

  # animal_genre(中間テーブル)とのアソシエーション
  has_many :animal_genres, dependent: :destroy
  has_many :genres, through: :animal_genres, dependent: :destroy

  # コメントのアソシエーション
  has_many :comments, dependent: :destroy

  # 名前のバリデーション
  validates :name, presence: true

  # 動物種のバリデーション
  validates :genre_ids, presence: true

   # 説明文バリデーション
  validates :introduct, presence: true, length: {in: 5..10000 }

  # 画像を複数投稿/画像のバリデーション
  has_many_attached :images
  validates :images, presence: true
  validate :validate_image_number

  # 退会した施設が投稿した動物を表示しないようにする
  scope :active, -> { joins(:facility).where(facilities: { is_deleted: false }) }

  # タグとのアソシエーション
  has_many :animal_tags, dependent: :destroy
  has_many :tags, through: :animal_tags

  # タグの新規投稿と更新
  def save_tags(tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:tag) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete　Tag.find_by(tag: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_animal_tag = Tag.find_or_create_by(tag: new)
      self.tags << new_animal_tag
    end
  end

  private

  def validate_image_number
    errors.add(:images, 'は3枚までです。') if images.size > 3
  end

end