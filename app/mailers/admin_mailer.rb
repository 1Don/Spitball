class AdminMailer < ApplicationMailer
	default from: 'no-reply@spitball.io'

	def flag_notice(url)
		@url = url
		mail(to: 'team@spitball.io', subject: 'flagged content')
	end 

	def new_user_alert(url)
		@url = url
		mail(to: 'team@spitball.io', subject: 'flagged content')
	end 




end
