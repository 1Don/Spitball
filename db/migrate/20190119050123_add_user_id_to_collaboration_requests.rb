class AddUserIdToCollaborationRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :collaboration_requests, :user_id, :integer
  end
end
