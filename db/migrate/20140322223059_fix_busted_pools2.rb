class FixBustedPools2 < ActiveRecord::Migration
  def up
    remove_column :pools, :q6a
    add_column :pools, :q5a, :string
    end
end
