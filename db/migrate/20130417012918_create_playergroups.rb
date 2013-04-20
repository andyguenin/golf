class CreatePlayergroups < ActiveRecord::Migration
  def change
    create_table :playergroups do |t|
      t.integer :tournament_id
      t.integer :rank

      t.timestamps
    end
  end
end
