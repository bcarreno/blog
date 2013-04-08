class Article < ActiveRecord::Base
  attr_accessible :body, :keywords, :title, :created_at, :category_ids, :is_published, :comments_allowed, :markdown, :cached_slug, :comments_attributes
  has_many :comments, :dependent => :delete_all
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :comments, :allow_destroy => true
  is_sluggable :title, :history => false
  scope :published, where(:published => true)
  paginates_per 4

  def self.visibles(user=nil)
    if user && user.admin
      self.scoped
    else
      self.where(:is_published => true)
    end
  end
end
