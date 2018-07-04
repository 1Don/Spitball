class CreateFriendRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :friend_requests do |t|
      t.references :user, index: true
      t.references :friend, index: true

      t.timestamps
    end
    add_foreign_key :friend_requests, :users, column: :user_id
    add_foreign_key :friend_requests, :users, column: :friend_id
  end
end
