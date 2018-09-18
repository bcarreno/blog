class Article < ApplicationRecord
  has_many :comments, :dependent => :delete_all
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :comments, :allow_destroy => true
  is_sluggable :title, :history => false
  paginates_per 4

  def self.visibles(user=nil)
    if user && user.admin
      self.all
    else
      self.where(:is_published => true)
    end
  end

  def visible?(user=nil)
    is_published || user.try(:admin)
  end
end
