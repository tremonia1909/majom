class UserMailer < ActionMailer::Base
  default from: "notification@majom.net"
  layout 'mailer'

  def welcome_email(current_user)
    @user = current_user
    @url  = 'http://localhost:3000/users/sign_in'
    mail(to: current_user.email, subject: 'Willkommen zu Majom')
  end
end
