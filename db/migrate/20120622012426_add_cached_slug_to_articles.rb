class AddCachedSlugToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :cached_slug, :string
    add_index :articles,  :cached_slug
  end
end
