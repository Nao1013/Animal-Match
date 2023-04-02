class Animal < ApplicationRecord

  # 施設側とのアソシエーション
  belongs_to :facility

  # tagとのアソシエーション
  has_many :animal_tags,dependent: :destroy
  has_many :tags,through: :animal_tags

  # tagについて
  # Tagの新橘高陽メソッド
 def save_tags(new_tags)
    new_tags.each do |new_tag|
      # selfは明示的に記載していてこの場合だとコントローラーの@animalになる
      # animal_tagsがthroughしているのでtagsでアソシエーションを指定すると中間テーブルを通過した際に保存される。
      tag = Tag.find_or_create_by(tag: new_tag)
      self.tags << tag
    end
 end

  # タグ付けの更新用メソッド
  def update_tags(latest_tags)
    self.animal_tags.destroy_all

    latest_tags.each do |tag|
      tag = Tag.find_or_create_by(tag: tag)
      self.tags << tag
    end

    # if self.tags.empty?
    #   # 既存のタグがなかったら追加だけ行う
    #   latest_tags.each do |latest_tag|
    #     self.tags.find_or_create_by(tag: latest_tag)
    #   end
    # elsif latest_tags.empty?
    #   # 更新対象のタグがなかったら既存のタグをすべて削除
    #   # 既に保存がされていたら既に登録されているタグの内容を削除
    #   self.tags.each do |tag|
    #     self.tags.delete(tag)
    #   end
    # else
    #   # 既存のタグも更新対象のタグもある場合は差分更新
    #   current_tags = self.tags.pluck(:tag)
    #   #左を起点に引き算をする
    #   #　　　　　　 b             a b c
    #   old_tags = current_tags - latest_tags
    #   #一致したものを取り出す
    #   # a c       a b c            b
    #   new_tags = latest_tags - current_tags

    #   # a  c
    #   old_tags.each do |old_tag|
    #     tag = self.tags.find_by(tag: old_tag)
    #     self.tags.delete(tag) if tag.present?
    #   end


    #   new_tags.each do |new_tag|
    #     # b
    #     self.tags.find_or_create_by(tag: new_tag)
    #   end
    # end
  end

  # タグ検索
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
