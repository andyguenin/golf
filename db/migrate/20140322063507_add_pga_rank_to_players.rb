class AddPgaRankToPlayers < ActiveRecord::Migration
  def change
	add_column :players, :pga_rank, :integer
	add_column :players, :pga_rank_update, :date
	add_column :players, :pga_rank_status, :string
  end
end
