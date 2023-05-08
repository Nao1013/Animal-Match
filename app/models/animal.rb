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

  # タグとのアソシエーション
  has_many :animal_tags, dependent: :destroy
  has_many :tags, through: :animal_tags

 # タグ付けの新規投稿用メソッド
  def save_tags(tags)
    tags.each do |new_tags|
      # selfはこの場合コントローラーの@animalになる
      # anial_tagsがthroughしているのでtagsでアソシエーションを指定すると中間テーブルを通過した際に保存される。
      self.tags.find_or_create_by(tag: new_tags)
    end
  end

  # タグ付けの更新用メソッド
  def update_tags(latest_tags)
    if self.tags.empty?
      # 既存のタグがなかったら追加だけ行う
      latest_tags.each do |latest_tag|
        self.tags.find_or_create_by(tag: latest_tag)
      end
    elsif latest_tags.empty?
      # 更新対象のタグがなかったら既存のタグをすべて削除
      # 既に保存がされていたら既に登録されているタグの内容を削除
      self.tags.each do |tag|
        self.tags.delete(tag)
      end
    else
      # 既存のタグも更新対象のタグもある場合は差分更新
      current_tags = self.tags.pluck(:tag)
      #左を起点に引き算をする
      #　　　　　　 b             a b c
      old_tags = current_tags - latest_tags
      #一致したものを取り出す
      # a c       a b c            b 
      new_tags = latest_tags - current_tags

      # a  c
      old_tags.each do |old_tag|
        tag = self.tags.find_by(tag: old_tag)
        self.tags.delete(tag) if tag.present?
      end

      new_tags.each do |new_tag|
        # b
        self.tags.find_or_create_by(tag: new_tag)
        # self.tags << new_tags
      end
    end
  end

  private

  def validate_image_number
    errors.add(:images, 'は3枚までです。') if images.size > 3
  end

end
