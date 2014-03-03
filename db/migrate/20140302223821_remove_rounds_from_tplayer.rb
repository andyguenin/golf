class RemoveRoundsFromTplayer < ActiveRecord::Migration
  def up
    remove_column :tplayers, :round
    remove_column :tplayers, :rank
    remove_column :tplayers, :hole
  end

  def down
    add_column :tplayers, :round, :integer
    add_column :tplayers, :rank, :integer
    add_column :tplayers, :hole, :integer
  end
end
