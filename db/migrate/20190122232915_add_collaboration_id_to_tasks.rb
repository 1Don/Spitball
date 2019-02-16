class AddCollaborationIdToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :collaboration_id, :integer
  end
end
