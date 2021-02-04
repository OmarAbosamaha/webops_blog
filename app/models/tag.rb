class Tag < ApplicationRecord
  has_and_belongs_to_many :posts

  validates :body, presence: true, :allow_blank => false
end
