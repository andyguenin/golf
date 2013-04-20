class AddPoolToGolfpicks < ActiveRecord::Migration
  def change
    add_column :golfpicks, :pool_id, :integer
  end
end
