class CreatePlayerPlayergroupMembers < ActiveRecord::Migration
  def change
    create_table :player_playergroup_members do |t|
      t.integer :player_id
      t.integer :playergroup_id

      t.timestamps
    end
  end
end
