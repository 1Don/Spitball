# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
=begin
  def welcome_email
    UserMailer.welcome_email(User.first)
  end

  def notifications_email
    UserMailer.notifications_email(User.find_by(name: "isaiah_thompkins"))
  end
=end
end
