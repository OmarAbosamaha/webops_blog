# table "comments"
#   text "body"
#   bigint "user_id", null: false
#   bigint "post_id", null: false
#   datetime "created_at", precision: 6, null: false
#   datetime "updated_at", precision: 6, null: false
#   index ["post_id"], name: "index_comments_on_post_id"
#   index ["user_id"], name: "index_comments_on_user_id"


class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # accepts_nested_attributes_for :post
  validates_associated :user
  validates_associated :post
  validates :body, presence: true, :allow_blank => false
end
