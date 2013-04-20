class CreatePlayergroupPlayers < ActiveRecord::Migration
  def change
    create_table :playergroup_players do |t|
      t.integer :playergroup_id
      t.integer :player_id

      t.timestamps
    end
  end
end
