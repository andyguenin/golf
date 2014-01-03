class AddRoundAndHoleToTplayers < ActiveRecord::Migration
  def change
    add_column :tplayers, :round, :integer
    add_column :tplayers, :hole, :integer
  end
end
