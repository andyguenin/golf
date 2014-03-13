set :stage, :production
set :branch,  "production"

set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"

server '162.243.252.118', user: 'deployer', roles: %w{web app db}, primary: true

set :deploy_to, "/home/deployer/prod/golf"

set :ssh_options, { :forward_agent => true }

set :rails_env, :production

set :unicorn_worker_count, 5

set :enable_ssl, false

