class Comment < ApplicationRecord
  belongs_to :reader
  belongs_to :animal
  
  validates :comment, presence: true, length: { minimum: 1 } 
end
