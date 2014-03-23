class FixBustedPools3 < ActiveRecord::Migration
  def change
    remove_column :pools, :q1a
    remove_column :pools, :q2a
    remove_column :pools, :q3a
    remove_column :pools, :q4a
    remove_column :pools, :q5a
    add_column :pools, :q1a, :boolean
    add_column :pools, :q2a, :boolean
    add_column :pools, :q3a, :boolean
    add_column :pools, :q4a, :boolean
    add_column :pools, :q5a, :boolean
  end
end
