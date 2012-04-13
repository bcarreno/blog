class Comment < ActiveRecord::Base
  attr_accessible :article_id, :body, :email, :name
end
