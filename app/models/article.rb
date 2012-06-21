class Article < ActiveRecord::Base
  attr_accessible :body, :keywords, :title, :created_at, :category_ids, :comments_attributes
  has_many :comments, :dependent => :delete_all
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :comments, :allow_destroy => true
end
