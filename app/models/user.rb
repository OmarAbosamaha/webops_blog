# Schema: User(username:string, email:string, image:text, password_digest:string)
class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :comments


  validates :username, presence: true, uniqueness: true, :allow_blank => false
  validates :email, presence: true, uniqueness: true, :allow_blank => false
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, :allow_blank => false
end
