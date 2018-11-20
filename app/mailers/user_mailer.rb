class UserMailer < ApplicationMailer
	default from: 'no-reply@spitball.io'

	def welcome_email(user)
		if user
			@user = user
		    @url  = 'http://spitball.io'
		    mail(to: @user.email, subject: 'Thanks for joining!')
		else
		    @user = params[:user]
		    @url  = 'http://spitball.io'
		    mail(to: @user.email, subject: 'Thanks for joining!')
		end
 	end
end
