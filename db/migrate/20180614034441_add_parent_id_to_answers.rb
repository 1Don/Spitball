class AddParentIdToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :parent_id, :integer
  end
end
