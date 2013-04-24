class AddSlugToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :slug, :string
  end
end
