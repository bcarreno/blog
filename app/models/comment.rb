class Comment < ActiveRecord::Base
  attr_accessible :article_id, :body, :email, :name, :created_at
  belongs_to :article
  validates :name, :body, :presence => true
  validates :email, :format => {:with => /\A\s*[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\s*\Z/}, :unless => "email.blank?"
end
