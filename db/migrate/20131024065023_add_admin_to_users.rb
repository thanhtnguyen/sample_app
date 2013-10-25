class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false # "default: false" mean user will not be administrators by default
  end
end
