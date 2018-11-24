class UserMailer < ApplicationMailer
	default from: 'no-reply@spitball.io'

	def notifications_email(user)
		@notifications = Notification.where(recipient: user, created_at: 5.days.ago..Time.current).reverse
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
