class NotifierMailer < ApplicationMailer
  def confirm_email(user)
    @user = user
    mail(to: user.email, subject: I18n.t('notifier_mailer.confirm_email.subject'))
  end

  def reset_password(user)
    @user = user
    mail(to: user.email, subject: I18n.t('notifier_mailer.reset_password.subject'))
  end
end
