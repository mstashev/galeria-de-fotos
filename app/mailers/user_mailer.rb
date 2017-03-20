class UserMailer < ApplicationMailer

  def signup(user)
    @user = user
    mail(to: @user.email, subject: "¡Welcome to Gallería Do Fotos!")
  end

end
