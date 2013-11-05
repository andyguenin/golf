class AddLocationToCourse < ActiveRecord::Migration
  def change
	add_column :courses, :location, :string
  end
end
