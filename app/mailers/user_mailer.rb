class UserMailer < ApplicationMailer

  default from: "nao-responda@elevatech.com.br"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_user.subject
  #
  def new_user(user, password, raw)
    @user = user
    @password = password
    @raw = raw
    mail(to: @user.email, subject: "Bem vindo ao Eventos & Rankings!")
  end
end