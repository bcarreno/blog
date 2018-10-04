class CreateComments < ActiveRecord::Migration[4.2]
  def change
    create_table :comments do |t|
      t.string :name
      t.string :email
      t.text :body
      t.integer :article_id, :null => false

      t.timestamps
    end
  end
end
