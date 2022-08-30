class RenameColumnUsernameInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :username, :first_name
  end
end
