class CreateCollaborationRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :collaboration_requests do |t|
      t.text :body
      t.integer :collaboration_id

      t.timestamps
    end
  end
end
