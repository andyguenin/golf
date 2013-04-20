class CreateGolfpicks < ActiveRecord::Migration
  def change
    create_table :golfpicks do |t|
      t.integer :user_id
      t.integer :pick1
      t.integer :pick2
      t.integer :pick3
      t.integer :pick4
      t.integer :pick5
      t.boolean :q1
      t.boolean :q2
      t.boolean :q3
      t.boolean :q4
      t.boolean :q5
      t.integer :tiebreak

      t.timestamps
    end
  end
end
