# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'golf'
set :deploy_user, 'deploy'

set :scm, :git
set :repo_url, 'git@github.com:andyguenin/golf.git'


set :rbenv_ruby, '2.1.1p76'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

set :keep_releases, 5


after "deploy:publishing", "deploy:restart"
#after "deploy:restart", "deploy:restart_workers"


namespace :deploy do
  task :start do
    run "touch #{deploy_to}/tmp/restart.txt"
  end
 
  task :stop  do
    # Do nothing.
  end
 
  desc "Restart Application"
  task :restart do
    on roles(:all) do
      execute "mkdir -p #{deploy_to}/current/tmp; touch #{deploy_to}/current/tmp/restart.txt"
    end
    
  end

  task :load_schema do       # Overriding the default deploy:cold
      #update
      on roles(:all) do 
        execute "cd #{current_path}; RAILS_ENV=production ~/.rvm/bin/rvm default do bundle exec rake db:setup"
      end
      #start
    end

    

    #desc "Restart Resque Workers"
    #task :restart_workers, :roles => :worker do
    #  run_remote_rake "resque:restart_workers"
    #end
end

