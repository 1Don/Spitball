class AddBucketIdToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :bucket_id, :integer
  end
end
