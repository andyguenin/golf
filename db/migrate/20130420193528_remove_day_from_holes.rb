class RemoveDayFromHoles < ActiveRecord::Migration
  def up
    remove_column :holes, :day
  end
end
