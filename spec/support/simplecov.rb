require 'simplecov'

SimpleCov.start 'rails' do
  add_filter %r{^/app/admin/}
  add_filter %r{^/spec/}
  add_filter %r{^/app/models}
  add_filter %r{^/app/lib}
  add_filter %r{^/lib}
  add_filter '/config/'
  add_filter '/vendor/'

  # Channels
  add_filter 'app/channels/application_cable/channel.rb'
  add_filter 'app/channels/application_cable/connection.rb'

  # Jobs
  add_filter 'app/jobs/application_job.rb'

  # Mailers
  add_filter 'app/mailers/application_mailer.rb'

  # Controllers
  add_filter 'app/controllers/application_controller.rb'

  # Interactions
  add_group 'Interactions', 'app/interactions/v1'

  # Services
  add_group 'Services', 'app/services'
end
