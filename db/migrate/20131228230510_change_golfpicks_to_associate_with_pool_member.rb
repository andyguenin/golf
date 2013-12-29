class ChangeGolfpicksToAssociateWithPoolMember < ActiveRecord::Migration
  def up
    remove_column :golfpicks, :pool_id
    add_column :golfpicks, :pool_member_id, :integer
  end

  def down
    remove_column :golfpicks, :pool_member_id
    add_column :golfpicks, :pool_id, :integer
  end
end
