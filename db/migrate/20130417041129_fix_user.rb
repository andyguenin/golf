class FixUser < ActiveRecord::Migration
  def change
    remove_column :users, :sigid
    remove_column :users, :pool_id
  end
end
