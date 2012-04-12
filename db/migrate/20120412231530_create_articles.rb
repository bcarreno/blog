class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :keywords
      t.text :body

      t.timestamps
    end
  end
end
