class Article < ActiveRecord::Base
  attr_accessible :body, :keywords, :title, :created_at, :category_ids
  has_many :comments
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :comments, :allow_destroy => true
end
