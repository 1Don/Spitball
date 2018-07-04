class CreateConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :conversations do |t|
    	t.integer :sender_id, index: true
		t.integer :recipient_id, index: true
		t.timestamps
    end
    add_foreign_key :conversations, :users, column: :sender_id
    add_foreign_key :conversations, :users, column: :recipient_id
	end
end
