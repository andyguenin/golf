class AddNonadminInviteToPool < ActiveRecord::Migration
  def change
    add_column :pools, :nonadmin_invite, :boolean
  end
end
