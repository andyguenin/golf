class AddScoreToPicks < ActiveRecord::Migration
  def change
    add_column :picks, :score, :integer
    add_column :picks, :bonus, :integer
  end
end
