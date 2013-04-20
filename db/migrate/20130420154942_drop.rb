class Drop < ActiveRecord::Migration
  def up
    drop_table :player_playergroup_members
    drop_table :playergroup_players
    drop_table :playergroups
  end
end
