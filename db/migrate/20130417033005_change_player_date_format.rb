class ChangePlayerDateFormat < ActiveRecord::Migration
  def change
    remove_column :tournaments, :starttime
    remove_column :tournaments, :endtime
    add_column :tournaments, :starttime, :datetime
    add_column :tournaments, :endtime, :datetime
  end
end
