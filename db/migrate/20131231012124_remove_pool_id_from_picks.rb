class RemovePoolIdFromPicks < ActiveRecord::Migration
  def up
    remove_column :picks, :pool_id
  end

  def down
    add_column :picks, :pool_id, :integer
  end
end
