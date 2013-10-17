class CreateUsers < ActiveRecord::Migration
  def change #=> create "users" table with "name", "email" columns, and "t.timestamps", is a special command that creates two magic columns called "created_at" and "updated_at"
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
