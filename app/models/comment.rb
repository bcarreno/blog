class Comment < ApplicationRecord
  belongs_to :article
  validates :name, :body, :presence => true
  validates :email, :format => {:with => /\A\s*[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\s*\Z/}, unless: :blank?
end
