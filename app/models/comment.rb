class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  accepts_nested_attributes_for :post
  validates_associated :user
  validates_associated :post
  validates :body, presence: true
end
