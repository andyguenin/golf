class AddSlugToPools < ActiveRecord::Migration
  def change
	add_column :pools, :slug, :string
  end
end
