class ChangeHoleToIdScores < ActiveRecord::Migration
  def change
    remove_column :scores, :hole
    add_column :scores, :hole_id, :integer
  end
end
