class AddCachedSlugToArticles < ActiveRecord::Migration[4.2]
  def change
    add_column :articles, :cached_slug, :string
    add_index :articles,  :cached_slug
  end
end
