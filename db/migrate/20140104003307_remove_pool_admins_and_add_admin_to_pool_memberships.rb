class RemovePoolAdminsAndAddAdminToPoolMemberships < ActiveRecord::Migration
  def up
    add_column :pool_memberships, :admin, :boolean
    drop_table :pool_admins
  end
end
