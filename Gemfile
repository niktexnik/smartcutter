source 'https://rubygems.org'
ruby '3.1.2'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', require: false
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'
gem 'tzinfo-data', platforms: %i[mswin mswin64 mingw x64_mingw jruby]
# Dry rb
gem 'dry-monads'
gem 'dry-transaction'
gem 'dry-validation'
# Models
gem 'annotate'

# Notifications
gem 'fcm'

# Scheduler
gem 'whenever', require: false

# Background Jobs
gem 'sidekiq'

# Serialization
gem 'active_model_serializers'
gem 'acts_as_list'
gem 'devise'

# images
gem 'carrierwave'
gem 'mini_magick'

# docs
gem 'rswag'
gem 'rswag-api'
gem 'rswag-ui'
group :development, :test do
  gem 'debug', platforms: %i[mri mswin mswin64 mingw x64_mingw]
  # Testing
  gem 'rspec-rails'

  gem 'database_cleaner', github: 'DatabaseCleaner/database_cleaner'
  gem 'factory_bot_rails', require: false
  gem 'faker', github: 'stympy/faker'
  gem 'rswag-specs'
  gem 'simplecov', require: false
  gem 'webmock'
end

group :development do
  gem 'spring'
  # SQL formatter
  gem 'pp_sql'
  # Code styling
  gem 'rubocop', require: false
  gem 'rubocop-rspec'
  # Mail previewer
  gem 'letter_opener'
end

group :console do
  gem 'awesome_print'
end
