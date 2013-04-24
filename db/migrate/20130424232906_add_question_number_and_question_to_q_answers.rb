class AddQuestionNumberAndQuestionToQAnswers < ActiveRecord::Migration
  def change
    add_column :q_answers, :question, :string
    add_column :q_answers, :number, :integer
  end
end
