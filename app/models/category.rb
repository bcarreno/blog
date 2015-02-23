class Category < ActiveRecord::Base
  attr_accessible :description, :name
  has_and_belongs_to_many :articles
  validates_presence_of :name
end
