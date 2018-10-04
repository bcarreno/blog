class RemovePasswordSaltFromUsers < ActiveRecord::Migration[4.2]
  def up
    remove_column :users, :password_salt
  end

  def down
    add_column :users, :password_salt, :string
  end
end
