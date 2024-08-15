source 'https://rubygems.org'
ruby '3.3.0'
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

# images
gem 'carrierwave'
gem 'mini_magick'

# docs
gem 'rswag'

# views
gem 'slim'

# Pagination
gem 'kaminari'

group :development, :test do
  # deploy
  gem 'brakeman'
  gem 'capistrano', require: false
  gem 'capistrano3-puma', github: 'seuros/capistrano-puma'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'debug', platforms: %i[mri mswin mswin64 mingw x64_mingw]
  # Testing
  gem 'capybara'
  gem 'database_cleaner', github: 'DatabaseCleaner/database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker', github: 'stympy/faker'
  gem 'rspec-rails'
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
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec'
  # Mail previewer
  gem 'letter_opener'

  gem 'ruby-lsp'
end

group :console do
  gem 'awesome_print'
end
