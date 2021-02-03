class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :tags

  validates :username, presence: true
  validates :password, presence: true
  validates :password, length: { in: 6..20 }
  validates :email, presence: true
end
