class AddBonusToPicks < ActiveRecord::Migration
  def change
    add_column :picks, :bonus, :integer
    add_column :picks, :active_players, :integer
  end
end
