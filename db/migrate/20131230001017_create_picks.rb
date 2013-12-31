class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.integer :pool_membership_id
      t.integer :pool_id

      t.timestamps
    end
  end
end
