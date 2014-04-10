class AddAAndXToTplayers < ActiveRecord::Migration
  def change
    add_column :tplayers, :a, :boolean
    add_column :tplayers, :x, :boolean
  end
end
