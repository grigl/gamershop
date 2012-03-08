class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def registration_confirmation(user)
    @user = user
    mail to: user.email, subject: 'registration activation'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'password reset'
  end
end
