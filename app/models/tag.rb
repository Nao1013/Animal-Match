class Tag < ApplicationRecord
   # タグは複数のタグを持つ。animal_tagsを参照して持つ
  has_many :animal_tags, dependent: :destroy
  # has_many :animals,through: :animal_tags
  has_many :animals, through: :animal_tags

  # タグ名のバリデーション
  validates :tag, uniqueness: true, presence: true
  # 重複NG
  validates :tag, uniqueness: true
  
end
