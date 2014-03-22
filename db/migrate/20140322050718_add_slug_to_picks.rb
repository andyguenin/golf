class AddSlugToPicks < ActiveRecord::Migration
  def change
	add_column :picks, :slug, :string
  end
end
