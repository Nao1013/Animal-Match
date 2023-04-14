class Message < ApplicationRecord
  belongs_to :reader
  belongs_to :facility
  belongs_to :room
  
  validates :body, presence: true, length: { in: 1..140 }
end
