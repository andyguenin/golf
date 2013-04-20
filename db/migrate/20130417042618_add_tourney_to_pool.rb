class AddTourneyToPool < ActiveRecord::Migration
  def change
    add_column :pools, :tournament_id, :integer
  end
end
