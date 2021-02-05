# table "tags"
#  string "body"
#  datetime "created_at", precision: 6, null: false
#  datetime "updated_at", precision: 6, null: false

class Tag < ApplicationRecord
  # has_and_belongs_to_many :posts
  has_many :post_tags
  has_many :posts, :through => :post_tags
  validates :body, presence: true, :allow_blank => false
end
