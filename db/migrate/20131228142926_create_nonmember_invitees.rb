class CreateNonmemberInvitees < ActiveRecord::Migration
  def change
    create_table :nonmember_invitees do |t|
      t.string :email
      t.integer :pool_id
      t.integer :inviter_id

      t.timestamps
    end
  end
end
