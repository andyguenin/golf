class AddPublishedToPools < ActiveRecord::Migration
  def change
    add_column :pools, :published, :boolean
  end
end
