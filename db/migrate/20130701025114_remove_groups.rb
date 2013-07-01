class RemoveGroups < ActiveRecord::Migration

  def up
    drop_table :group_admins
    drop_table :groups
    drop_table :user_group_members
    remove_column :pools, :group_id
  end

end
