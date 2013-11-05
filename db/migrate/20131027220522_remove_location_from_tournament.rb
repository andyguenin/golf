class RemoveLocationFromTournament < ActiveRecord::Migration
  def change
	remove_column :tournaments, :location
  end
end
