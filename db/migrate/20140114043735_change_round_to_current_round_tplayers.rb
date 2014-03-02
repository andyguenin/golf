class ChangeRoundToCurrentRoundTplayers < ActiveRecord::Migration
  def up
    remove_column :tplayers, :round
    add_column :tplayers, :current_round, :integer
  end
  
  def down
    remove_column :tplayers, :current_round
    add_column :tplayers, :round, :integer
  end
end
