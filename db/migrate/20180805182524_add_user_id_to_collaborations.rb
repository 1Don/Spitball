class AddUserIdToCollaborations < ActiveRecord::Migration[5.1]
  def change
    add_column :collaborations, :user_id, :integer
  end
end
