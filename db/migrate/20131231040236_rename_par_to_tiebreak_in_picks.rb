class RenameParToTiebreakInPicks < ActiveRecord::Migration
  def up
    remove_column :picks, :par
    add_column :picks, :tiebreak, :integer
  end

  def down
    remove_column :picks, :tiebreak
    add_column :picks, :par, :integer
  end
end
