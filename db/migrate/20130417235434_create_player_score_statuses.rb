class CreatePlayerScoreStatuses < ActiveRecord::Migration
  def change
    create_table :player_score_statuses do |t|
      t.integer :player_id
      t.integer :tournament_id
      t.integer :score

      t.timestamps
    end
  end
end
