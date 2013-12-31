class RemoveBonusFromPicks < ActiveRecord::Migration
  def up
    remove_column :picks, :bonus
  end
end
