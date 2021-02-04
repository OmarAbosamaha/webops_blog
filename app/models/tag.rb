# table "tags"
#  string "body"
#  datetime "created_at", precision: 6, null: false
#  datetime "updated_at", precision: 6, null: false



class Tag < ApplicationRecord
  has_and_belongs_to_many :posts

  validates :body, presence: true, :allow_blank => false
end
