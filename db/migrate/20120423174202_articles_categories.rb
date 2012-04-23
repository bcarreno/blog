class ArticlesCategories < ActiveRecord::Migration
  def change
    create_table :articles_categories, :id => false do |t|
      t.integer :article_id, :null => false
      t.integer :category_id, :null => false
    end
  end
end
