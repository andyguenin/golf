class ChangeEmailToUserInNonmemberInvitee < ActiveRecord::Migration
  def up
    remove_column :nonmember_invitees, :email
    add_column :nonmember_invitees, :user_id, :integer
  end

  def down
    add_column :nonmember_invitees, :email, :string
    remove_column :nonmember_invitees, :user_id
  end
end
