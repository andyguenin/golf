class AddScoreToGolfpicks < ActiveRecord::Migration
  def change
    add_column :golfpicks, :score, :integer
  end
end
