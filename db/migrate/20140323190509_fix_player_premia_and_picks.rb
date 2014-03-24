class FixPlayerPremiaAndPicks < ActiveRecord::Migration
  def change
    remove_column :player_premia, :player_id
    add_column :player_premia, :tplayer_id, :integer
    add_column :picks, :received_unit, :integer
  end
end
