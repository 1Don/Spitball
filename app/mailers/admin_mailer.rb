class AdminMailer < ApplicationMailer
	default from: 'no-reply@spitball.io'

	def flag_notice(url)
		@url = url
		mail(to: 'isaiah_thompkins@brown.edu', subject: 'flagged content')
	end 
end
