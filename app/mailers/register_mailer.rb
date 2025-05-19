class RegisterMailer < ApplicationMailer
  def registered_mail
    @user = params[:user]
    mail(to: "hoang@gmail.com", subject: "Welcome to us")
  end
end
