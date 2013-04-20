class EditParInHole < ActiveRecord::Migration
  def change
    remove_column :holes, :parr
    add_column :holes, :par, :integer
  end
end
