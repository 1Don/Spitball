class AddAnsweredIdToDiscussions < ActiveRecord::Migration[5.1]
  def change
    add_column :discussions, :answered_id, :integer
  end
end
