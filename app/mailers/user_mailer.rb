class UserMailer < ActionMailer::Base
  default from: "notification@majom.net"
  layout 'mailer'

  def welcome_email(user)
    @user = devcurrent_user.first_name
    @url  = 'http://localhost:3000/users/sign_in'
    mail(to: current_user.email, subject: 'Willkommen zu Majom')
  end
end
