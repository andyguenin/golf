class AddPoolToUser < ActiveRecord::Migration
  def change
    add_column :users, :pool_id, :integer
  end
end
