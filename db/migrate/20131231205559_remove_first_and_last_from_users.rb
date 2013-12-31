class RemoveFirstAndLastFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :first_name
    remove_column :users, :last_name
  end
end
