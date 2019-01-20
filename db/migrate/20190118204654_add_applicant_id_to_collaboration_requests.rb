class AddApplicantIdToCollaborationRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :collaboration_requests, :applicant_id, :integer
  end
end
