class ChangeToPoolMembershipsInPools < ActiveRecord::Migration
  def self.up
    rename_column :golfpicks, :pool_member_id, :pool_membership_id
  end

  def self.down
    rename_column :golfpicks, :pool_membership_id, :pool_member_id
  end
end