class AddRoundNumberToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :round, :integer
  end
end
