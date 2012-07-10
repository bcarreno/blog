class Message < ActiveRecord::Base
  attr_accessible :body, :email, :name
  validates :body, :presence => true
  validates :email, :format => {:with => /\A\s*[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\s*\Z/}
end
