class DropTablePlayerScoreStatuses < ActiveRecord::Migration
  def up
	drop_table :player_score_statuses
  end
end
