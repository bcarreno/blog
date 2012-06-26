class AddIsPublishedCommentsAllowedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :is_published, :boolean, :null => false, :default => false
    add_column :articles, :comments_allowed, :boolean, :null => false, :default => true
  end
end
