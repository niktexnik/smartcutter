# config valid for current version and patch releases of Capistrano
lock '~> 3.19.1'

set :application, 'smartcutter'
set :repo_url, 'git:smartcutter/smartcutter.git'

set :branch, `git rev-parse --abbrev-ref HEAD`.chomp
append :linked_files, 'config/master.key', 'config/credentials/staging.key'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'vendor', 'storage', 'credentials'

set :keep_releases, 5
set :default_env, -> { { worker_count: 2, deploy_to: fetch(:deploy_to) }.merge(fetch(:env, {})) }
set :rbenv_type, :user
set :rbenv_ruby, '3.3.0'

set :puma_bind, -> { ["unix://#{shared_path}/tmp/sockets/application.sock"] }
set :puma_worker_timeout, 30
set :puma_init_active_record, false
set :init_system, :systemd
set :log_level, :info

set :service_unit_user, :user
set :puma_service_unit_type, :simple
set :puma_enable_socket_service, true
set :puma_systemctl_user, :user
set :puma_phased_restart, true
