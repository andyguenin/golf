class RenamePoolMembersTable < ActiveRecord::Migration
   def self.up
       rename_table :pool_members, :pool_memberships
   end 
   def self.down
       rename_table :pool_memberships, :pool_members
   end
end