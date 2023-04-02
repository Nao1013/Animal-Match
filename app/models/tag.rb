class Tag < ApplicationRecord
  has_many :animal_tags,dependent: :destroy, foreign_key: 'tag_id'
  
  # タグは複数のタグを持つ。animal_tagsを参照して持つ
  has_many :animals,through: :animal_tags
  
  # タグ名のバリデーション
  validates :name, uniqueness: true, presence: true
  # 重複NG
  validates :name, uniqueness: true
end
