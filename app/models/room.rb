class Room < ApplicationRecord
  
  # DM実装アソシエーション
  belongs_to :facility
  belongs_to :reader
  has_many :messages, dependent: :destroy
  
end
