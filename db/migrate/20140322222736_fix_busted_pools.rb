class FixBustedPools < ActiveRecord::Migration
  def up
#    remove_column :pools, :q_answer_id1, :integer
#    remove_column :pools, :q_answer_id2, :integer
#    remove_column :pools, :q_answer_id3, :integer
#    remove_column :pools, :q_answer_id4, :integer
#    remove_column :pools, :q_answer_id5, :integer

    add_column :pools, :q1, :string
    add_column :pools, :q1a, :string
    add_column :pools, :q2, :string
    add_column :pools, :q2a, :string
    add_column :pools, :q3, :string
    add_column :pools, :q3a, :string
    add_column :pools, :q4, :string
    add_column :pools, :q4a, :string
    add_column :pools, :q5, :string
    add_column :pools, :q6a, :string
  end
end
