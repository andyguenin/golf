class AddDayToHoles < ActiveRecord::Migration
  def change
    add_column :holes, :day, :datetime
  end
end
