namespace :docs do
  namespace :all do
    task rspec: :environment do
      sh rspec_command
    end

    task generate: :environment do
      sh rspec_command('--format Rswag::Specs::SwaggerFormatter', '--order defined')
      sh 'cp docs/index.html public/docs/index.html'
    end

    def rspec_command(*extra_args)
      [
        'bundle exec rspec',
        '--pattern docs/**/*_spec.rb',
        '--require ./docs/rswag_config.rb',
        *extra_args
      ].join(' ')
    end
  end
end
