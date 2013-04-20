class AddBonusToGolfpicks < ActiveRecord::Migration
  def change
    add_column :golfpicks, :bonus, :integer
  end
end
