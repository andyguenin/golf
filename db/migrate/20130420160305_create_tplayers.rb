class CreateTplayers < ActiveRecord::Migration
  def change
    create_table :tplayers do |t|
      t.integer :player_id
      t.integer :tournament_id
      t.integer :bucket

      t.timestamps
    end
  end
end
