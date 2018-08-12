class UserMailer < ApplicationMailer
	def welcome_email
	    @user = params[:user]
	    @url  = 'http://spitball.io/login'
	    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
 	end
end
