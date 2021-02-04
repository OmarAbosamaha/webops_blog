# table "posts",
#   string "title"
#   text "body"
#   bigint "user_id", null: false
#   datetime "created_at", precision: 6, null: false
#   datetime "updated_at", precision: 6, null: false
#   index ["user_id"], name: "index_posts_on_user_id"


class Post < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :comments

  accepts_nested_attributes_for :tags
  validates :title, presence: true, :allow_blank => false
  validates :body, presence: true, :allow_blank => false

end
