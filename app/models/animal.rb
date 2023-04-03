class Animal < ApplicationRecord

  # 施設側とのアソシエーション
  belongs_to :facility
  
  # genreとのアソシエーション
  belongs_to :genre, dependent: :destroy

  # tagとのアソシエーション
  has_many :animal_tags,dependent: :destroy
  has_many :tags,through: :animal_tags

  # tagについて
  # Tagの新規投稿メソッド
 def save_tags(new_tags)
    new_tags.each do |new_tag|
      # selfは明示的に記載していてこの場合だとコントローラーの@animalになる
      # animal_tagsがthroughしているのでtagでアソシエーションを指定すると中間テーブルを通過した際に保存される。
      tag = Tag.find_or_create_by(tag: new_tag) # tag名が存在しないので中間テーブル(animal_tag)に保存される
      self.tags << tag # @animal.tags.save.tagということ
    end 
 end

  # タグ付けの更新用メソッド
  def update_tags(latest_tags)
    self.animal_tags.destroy_all # tagが既に記録されていても、全て削除する

    latest_tags.each do |tag|
      tag = Tag.find_or_create_by(tag: tag) # tag名が中間テーブルに存在している場合記録はしない（記録がなければ記録する）
      self.tags << tag
    end
  end

  # キーワード検索
  def self.search(search)
    if search != nil
      Animal.where('name LIKE(?) or introduct LIKE(?)' , "%#{search}%",  "%#{search}%")
    else
      Animal.all
    end
  end

  # 画像を複数投稿/画像のバリデーション
  has_many_attached :images
  validates :images, presence: true

end
