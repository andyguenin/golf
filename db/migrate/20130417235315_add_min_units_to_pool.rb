class AddMinUnitsToPool < ActiveRecord::Migration
  def change
    add_column :pools, :min_units, :integer
  end
end
