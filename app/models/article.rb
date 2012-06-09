class Article < ActiveRecord::Base
  attr_accessible :body, :keywords, :title, :category_ids
  has_many :comments
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :comments, :allow_destroy => true

  # TODO is this necessary?, what about validationsin the comments model?
  #      are they evaluated?
  # from http://guides.rubyonrails.org/getting_started.html
#    accepts_nested_attributes_for :tags, :allow_destroy => :true,
#    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
end
