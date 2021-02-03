class Post < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :comments

  accepts_nested_attributes_for :tags
  validates_associated :user
  validates_associated :tag
  validates :title, presence: true
  validates :body, presence: true
end
