class AddRankingToTplayers < ActiveRecord::Migration
  def change
    add_column :tplayers, :rank, :string
  end
end
