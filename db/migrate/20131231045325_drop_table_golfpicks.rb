class DropTableGolfpicks < ActiveRecord::Migration
  def up
    drop_table :golfpicks
  end
end
