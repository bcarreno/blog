class AddMarkdownToArticles < ActiveRecord::Migration[4.2]
  def change
    add_column :articles, :markdown, :boolean, :null => false, :default => false
  end
end
