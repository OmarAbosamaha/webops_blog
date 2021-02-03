# Schema: User(username:string, email:string, image:text)
class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :comments
  has_many :tags

  validates :username, presence: true, uniqueness: true
  # validates :password, presence: true
  # validates :password, length: { in: 6..20 }
  validates :email, presence: true, uniqueness: true
end
