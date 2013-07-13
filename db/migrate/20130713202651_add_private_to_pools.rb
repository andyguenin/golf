class AddPrivateToPools < ActiveRecord::Migration
  def change
    add_column :pools, :private, :boolean
  end
end
