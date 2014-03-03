class AddRankToTplayers < ActiveRecord::Migration
  def change
    add_column :tplayers, :rank, :integer
  end
end
