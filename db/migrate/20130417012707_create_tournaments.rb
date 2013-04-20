class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.string :location
      t.time :starttime
      t.time :endtime

      t.timestamps
    end
  end
end
