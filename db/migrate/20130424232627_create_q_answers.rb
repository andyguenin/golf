class CreateQAnswers < ActiveRecord::Migration
  def change
    create_table :q_answers do |t|
      t.integer :pool_id
      t.boolean :answer

      t.timestamps
    end
  end
end
