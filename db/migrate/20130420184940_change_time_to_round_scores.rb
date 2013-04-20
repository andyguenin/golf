class ChangeTimeToRoundScores < ActiveRecord::Migration
  def change
    remove_column :holes, :day
    add_column :holes, :day, :integer
  end
end
