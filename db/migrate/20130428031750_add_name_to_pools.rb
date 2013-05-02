class AddNameToPools < ActiveRecord::Migration
  def change
    add_column :pools, :name, :string
  end
end
