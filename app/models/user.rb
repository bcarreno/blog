class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email, :name, :username
  validates_presence_of :password, on: :create
  validates_uniqueness_of :username
end
