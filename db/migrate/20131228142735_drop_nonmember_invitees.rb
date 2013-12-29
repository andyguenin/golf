class DropNonmemberInvitees < ActiveRecord::Migration
  def up
    drop_table :nonmember_invitees
  end

  def down
  end
end
