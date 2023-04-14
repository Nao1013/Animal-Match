class Room < ApplicationRecord
  belongs_to :reader
  belongs_to :facility
  has_many :messages, dependent: :destroy
end
