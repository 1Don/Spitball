class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@spitball.io'
  layout 'mailer'
end
