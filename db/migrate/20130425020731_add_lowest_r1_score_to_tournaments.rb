class AddLowestR1ScoreToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :low_score, :integer
  end
end
