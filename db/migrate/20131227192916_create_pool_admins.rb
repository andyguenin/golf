class CreatePoolAdmins < ActiveRecord::Migration
  def change
    create_table :pool_admins do |t|
      t.integer :user_id
      t.integer :pool_id
      t.boolean :creator

      t.timestamps
    end
  end
end
