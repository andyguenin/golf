class AddFourOtherQanswersToPools < ActiveRecord::Migration
  def change
    remove_column :pools, :q_answer_id
    add_column :pools, :q_answer_id1, :integer
    add_column :pools, :q_answer_id2, :integer
    add_column :pools, :q_answer_id3, :integer
    add_column :pools, :q_answer_id4, :integer
    add_column :pools, :q_answer_id5, :integer
  end
end
