class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :tplayer_id
      t.integer :round
      t.integer :h1
      t.integer :h2
      t.integer :h3
      t.integer :h4
      t.integer :h5
      t.integer :h6
      t.integer :h7
      t.integer :h8
      t.integer :h9
      t.integer :h10
      t.integer :h11
      t.integer :h12
      t.integer :h13
      t.integer :h14
      t.integer :h15
      t.integer :h16
      t.integer :h17
      t.integer :h18

      t.timestamps
    end
  end
end
