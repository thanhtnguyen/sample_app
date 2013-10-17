class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :users, :email, unique: true #add an index on the email column of the users table #=> to make sure email is unique
  end
end
