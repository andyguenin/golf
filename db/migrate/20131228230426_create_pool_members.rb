class CreatePoolMembers < ActiveRecord::Migration
  def change
    create_table :pool_members do |t|
      t.integer :user_id
      t.integer :pool_id
      t.boolean :active

      t.timestamps
    end
  end
end
