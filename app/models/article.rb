class Article < ActiveRecord::Base
  attr_accessible :body, :keywords, :title
  has_many :comments
  accepts_nested_attributes_for :comments, :allow_destroy => true
end
