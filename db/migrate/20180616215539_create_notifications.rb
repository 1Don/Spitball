class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.integer :actor_id
      t.boolean :read, :default => false
      t.string :action
      t.integer :notifiable_id
      t.string :notifiable_type
    end
  end
end
