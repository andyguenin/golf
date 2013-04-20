class ChangePlayerScoreToRank < ActiveRecord::Migration
  def change
    add_column :players, :ranking, :integer
    remove_column :players, :score
  end
end
