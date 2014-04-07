# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'golf'
set :deploy_user, 'deploy'

set :scm, :git
set :repo_url, 'git@github.com:andyguenin/golf.git'


set :keep_releases, 5

set :rvm_ruby_string, :local               # use the same ruby as used 
set :rvm_autolibs_flag, "read-only"        # more info: rvm help autolibs


set :use_sudo, true

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
end

namespace :foreman do
  desc "Export the Procfile to Ubuntu's upstart scripts"
  task :export do
     on roles(:all) do
       execute "cd #{deploy_to} && sudo bundle exec foreman export upstart /etc/init -a golf-scraper -u deploy -l #{deploy_to}/log"
     end
  end
  
  desc "Start the application services"
  task :start do
    on roles(:all) do
      execute "sudo start golf-scraper"
    end
  end
 
  desc "Stop the application services"
  task :stop do
    on roles(:all) do
      execute "sudo stop golf-scraper"
    end
  end
 
  desc "Restart the application services"
  task :restart do
    on roles(:all) do
      execute "sudo start golf-scraper || sudo restart golf-scraper"
    end
  end
end
 
#after "deploy:update", "foreman:export"
#after "deploy:update", "foreman:restart"