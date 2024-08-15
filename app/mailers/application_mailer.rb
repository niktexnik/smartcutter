class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.fetch(:smtp_user_email, "no_reply@dentalis-#{Rails.env}.mail.com")
  layout 'mailer'
end
