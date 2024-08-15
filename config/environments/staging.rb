require 'active_support/core_ext/integer/time'
require Rails.root.join('config/environments/production')

Rails.application.configure do
  routes.default_url_options = { host: '', protocol: 'https' }

  # mailer
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: '' }
  routes.default_url_options = { host: '' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'smtp.yandex.ru',
    port: 465,
    user_first_name: Rails.application.credentials['smtp_login'],
    password: Rails.application.credentials['smtp_user_password'],
    authentication: :plain,
    enable_starttls_auto: true,
    ssl: true
  }
end
