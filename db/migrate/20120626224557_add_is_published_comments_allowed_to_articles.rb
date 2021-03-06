class AddIsPublishedCommentsAllowedToArticles < ActiveRecord::Migration[4.2]
  def change
    add_column :articles, :is_published, :boolean, :null => false, :default => false
    add_column :articles, :comments_allowed, :boolean, :null => false, :default => true
  end
end
