class User < ActiveRecord::Base
  attr_accessible :username, :email, :name, :password, :password_confirmation
  has_secure_password

  validates_presence_of :username
  validates_presence_of :email
  validates_presence_of :name
  validates_uniqueness_of :username
end
