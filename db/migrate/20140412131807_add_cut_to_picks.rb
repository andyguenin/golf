class AddCutToPicks < ActiveRecord::Migration
  def change
    add_column :picks, :cut, :boolean
  end
end
