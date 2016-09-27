class User < ActiveRecord::Base
  has_and_belongs_to_many :events
  
  validates :email, presence: true
  validates :password_digest, presence: true
  validates :gender, presence: true
  
  has_secure_password
end
