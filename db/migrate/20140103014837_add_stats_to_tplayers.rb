class AddStatsToTplayers < ActiveRecord::Migration
  def change
    add_column :tplayers, :deagle, :integer
    add_column :tplayers, :eagle, :integer
    add_column :tplayers, :birdie, :integer
    add_column :tplayers, :par, :integer
    add_column :tplayers, :bogey, :integer
    add_column :tplayers, :dbogey, :integer
    add_column :tplayers, :tbogey, :integer
  end
end
