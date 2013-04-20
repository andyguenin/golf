class ChangeDayToRoundScores < ActiveRecord::Migration
  def change
    remove_column :scores, :day
    add_column :scores, :round, :integer
  end
end
