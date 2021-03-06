class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string :login, :null => false
      t.string :email, :null => false
      t.string :email, :null => false
      t.string :name, :null => false
      t.string :password_hash, :null => false
      t.string :password_salt, :null => false

      t.timestamps
    end
  end
end
