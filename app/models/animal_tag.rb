class AnimalTag < ApplicationRecord
  # animal_tagはanimalに属している
  belongs_to :animal

  # animal_tagはtagに属している
  belongs_to :tag

  # ２つの外部キーのバリデーション
  validates :animal_id, presence: true
  validates :tag_id, presence: true
end
