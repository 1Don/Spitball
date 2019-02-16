class AddCollaborationIdToBuckets < ActiveRecord::Migration[5.2]
  def change
    add_column :buckets, :collaboration_id, :integer
  end
end
