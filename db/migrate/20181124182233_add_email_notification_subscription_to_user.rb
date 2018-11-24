class AddEmailNotificationSubscriptionToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email_notif_subscribe, :boolean, default: true
  end
end
