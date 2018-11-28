class UserMailer < ApplicationMailer
	default from: 'no-reply@spitball.io'

	def user_mail_coordinator
		User.where(email_notif_subscribe: true).each do |user|
			UserMailer.notifications_email(user)
		end
		sleep(7.days)
	end

	def notifications_email(user)
		@notifications = Notification.where(recipient: user, created_at: 7.days.ago..Time.current).reverse
		@user = user
		mail(to:user.email, subject: "This Week's Notifications")
	end

	def welcome_email(user)
		if user
			@user = user
		    @url  = 'http://spitball.io'
		    mail(to: @user.email, subject: 'Thanks for joining the Spitball alpha!')
		else
		    @user = params[:user]
		    @url  = 'http://spitball.io'
		    mail(to: @user.email, subject: 'Thanks for joining the Spitball alpha!')
		end
 	end
end
