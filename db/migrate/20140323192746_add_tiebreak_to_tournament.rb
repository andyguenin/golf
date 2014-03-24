class AddTiebreakToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :tiebreak, :integer
  end
end
