class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: true, presence: true
  validates :password, presence: true, length: { minimum: 8 }
  has_many :todos, dependent: :destroy
end
