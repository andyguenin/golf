class AddPoolIdToPools < ActiveRecord::Migration
  def change
    add_column :pools, :q_answer_id, :integer
    remove_column :q_answers, :pool_id
  end
end
