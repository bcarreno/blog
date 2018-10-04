class Rename < ActiveRecord::Migration[4.2]
  def up
    rename_column :users, :login, :username
  end

  def down
    rename_column :users, :username, :login
  end
end
