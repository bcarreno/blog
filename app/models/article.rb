class Article < ActiveRecord::Base
  attr_accessible :body, :keywords, :title
end
