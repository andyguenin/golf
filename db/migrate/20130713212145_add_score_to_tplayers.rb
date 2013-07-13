class AddScoreToTplayers < ActiveRecord::Migration
  def change
    add_column :tplayers, :score, :integer
  end
end
