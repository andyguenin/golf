class AddCreatorToPoolMemberships < ActiveRecord::Migration
  def change
    add_column :pool_memberships, :creator, :boolean
  end
end
