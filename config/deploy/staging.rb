set :stage, :staging
set :branch,  "staging"

set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"

server '162.243.252.118', user: 'deploy', roles: %w{web app db background}, primary: true

set :ssh_options_to, "/home/deploy/staging/golf"

set :deploy_to, "/home/deploy/staging/golf"

set :ssh_options, { :forward_agent => true }

set :rails_env, :staging

set :enable_ssl, false

