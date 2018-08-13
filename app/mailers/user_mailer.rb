class UserMailer < ApplicationMailer
	default from: 'no-reply@spitball.io'
	
	def welcome_email(user)
		if user
			@user = user
		    @url  = 'http://spitball.io/login'
		    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
		else
		    @user = params[:user]
		    @url  = 'http://spitball.io/login'
		    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
		end
 	end
end
