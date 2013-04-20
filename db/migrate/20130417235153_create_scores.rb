class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :tournament_id
      t.integer :player_id
      t.integer :hole
      t.integer :strokes

      t.timestamps
    end
  end
end
