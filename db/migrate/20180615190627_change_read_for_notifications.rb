class ChangeReadForNotifications < ActiveRecord::Migration[5.1]
  def change
  	change_column :notifications, :read, :boolean, :default => false
  end
end
