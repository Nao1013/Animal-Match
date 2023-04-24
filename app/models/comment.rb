class Comment < ApplicationRecord
  belongs_to :facility
  belongs_to :reader
  belongs_to :animal
end
