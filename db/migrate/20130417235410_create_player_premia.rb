class CreatePlayerPremia < ActiveRecord::Migration
  def change
    create_table :player_premia do |t|
      t.integer :pool_id
      t.integer :player_id
      t.integer :premium

      t.timestamps
    end
  end
end
