class RenameColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :password, :password_digest
    add_column :users, :password_recovery_digest, :string
  end
end
