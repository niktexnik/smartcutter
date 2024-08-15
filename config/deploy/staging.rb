# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# Testing host credentials
server '192.168.7.20',
       roles: %w[web app db],
       primary: true,
       user: 'deploy'

set :puma_threads, [4, 4]
set :puma_workers, 2

set :deploy_to, -> { "/home/deploy/apps/#{fetch(:application)}" }
