class AddStatusToTplayers < ActiveRecord::Migration
  def change
	add_column :tplayers, :status, :integer
  end
end
