class Comment < ApplicationRecord
  belongs_to :reader, optional: true
  belongs_to :animal
  belongs_to :facility, optional: true
  
  validates :comment, presence: true, length: { minimum: 1 } 
end
