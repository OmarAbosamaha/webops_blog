# Schema: User(username:string, email:string, image:text)
class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :comments
  

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
