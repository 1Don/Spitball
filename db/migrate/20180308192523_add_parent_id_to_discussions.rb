class AddParentIdToDiscussions < ActiveRecord::Migration[5.1]
  def change
    add_column :discussions, :parent_id, :integer
  end
end
