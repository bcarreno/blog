class RenameUsersPasswordHash < ActiveRecord::Migration[4.2]
  def up
    rename_column :users, :password_hash, :password_digest
  end

  def down
    rename_column :users, :password_digest, :password_hash
  end
end
