namespace :docs do
  desc 'Build and upload API docs'
  task :install do
    sh 'bundle exec rake docs:all:generate'

    on release_roles [:web, :app] do
      upload!('public/docs', File.join(shared_path, 'public/docs'), recursive: true)
    end
  end
end
