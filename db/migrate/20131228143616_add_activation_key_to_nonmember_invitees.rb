class AddActivationKeyToNonmemberInvitees < ActiveRecord::Migration
  def change
    add_column :nonmember_invitees, :activation_key, :string
  end
end
