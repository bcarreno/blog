class Comment < ActiveRecord::Base
  attr_accessible :article_id, :body, :email, :name, :created_at
  belongs_to :article
  validates :name, :body, :presence => true
end
