class FixPools < ActiveRecord::Migration
  def change
    remove_column :pools, :name
    add_column :pools, :group_id, :integer
  end
end
