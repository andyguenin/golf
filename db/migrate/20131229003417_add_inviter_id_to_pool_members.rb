class AddInviterIdToPoolMembers < ActiveRecord::Migration
  def change
    add_column :pool_members, :inviter_id, :integer
  end
end
