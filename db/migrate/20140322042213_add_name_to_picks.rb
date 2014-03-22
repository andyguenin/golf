class AddNameToPicks < ActiveRecord::Migration
  def change
	add_column :picks, :name, :string
  end
end
