class AddMarkdownToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :markdown, :boolean, :null => false, :default => false
  end
end
