class AddInformationToPicks < ActiveRecord::Migration
  def change
    add_column :picks, :p1, :integer
    add_column :picks, :p2, :integer
    add_column :picks, :p3, :integer
    add_column :picks, :p4, :integer
    add_column :picks, :p5, :integer
    add_column :picks, :q1, :boolean
    add_column :picks, :q2, :boolean
    add_column :picks, :q3, :boolean
    add_column :picks, :q4, :boolean
    add_column :picks, :q5, :boolean
    add_column :picks, :par, :integer
  end
end
