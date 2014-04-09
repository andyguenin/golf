class AddBonusesToTplayers < ActiveRecord::Migration
  def change
    add_column :tplayers, :r1_bonus, :integer
    add_column :tplayers, :r2_bonus, :integer
    add_column :tplayers, :r3_bonus, :integer
    add_column :tplayers, :r4_bonus, :integer
  end
end
