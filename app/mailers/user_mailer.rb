class UserMailer < ApplicationMailer
  default from: 'admin@ninetyninecats.com'

  def welcome_email(user)
    @user = user
    @url = new_sessions_url
    mail to: "#{@user.username}@mailinator.com", subject: 'Welcome to Ninety-Nine Cats!'

  end
end
