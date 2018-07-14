class AddSolutionToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :solution, :boolean
  end
end
