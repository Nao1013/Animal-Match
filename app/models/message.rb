class Message < ApplicationRecord
  
  # DMアソシエーション
  belongs_to :reader
  belongs_to :room
  belongs_to :facility
  
end
