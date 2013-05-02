class AddLockAttributeToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :locked, :boolean
  end
end
