class AddAdminAndSignupidToUser < ActiveRecord::Migration
  def change
    add_column :users, :sigid, :string
    add_column :users, :admin, :boolean
  end
end
