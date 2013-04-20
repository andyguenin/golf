class AddDayToScores < ActiveRecord::Migration
  def change
    add_column :scores, :day, :integer
  end
end
