class NotificationsController < ApplicationController
	before_action :require_login

	def index
		@notifications = Notification.where(recipient: current_user).last(5).reverse
		@index_notifications = Notification.where(recipient: current_user).reverse
	end

	def mark_as_read
		@notifications = Notification.where(recipient: current_user).unread
		@notifications.update_all(read: true)
		respond_to do |format|
			format.js { render json: { success: true } }
		end
	end
end
