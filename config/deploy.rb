# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'golf'
set :deploy_user, 'deploy'

set :scm, :git
set :repo_url, 'git@github.com:andyguenin/golf.git'


set :rben_type, :system
set :rbenv_ruby, '2.1.1p76'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

set :keep_releases, 5


namespace :deploy do
  task :start do
    run "touch #{current_release}/tmp/restart.txt"
  end
 
  task :stop  do
    # Do nothing.
  end
 
  desc "Restart Application"
  task :restart do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :cold do 
    transaction do 
      update
      setup_db
      start
    end
  end

  task :setup_db do 
    raise RuntimeError.new('db:setup aborted!') unless Capistrano::CLI.ui.ask("About to `rake db:setup`. Are you sure to wipe the entire database (anything other than 'yes' aborts):") == 'yes'
    run "cd #{current_path}; bundle exec rake db:setup RAILS_ENV=#{rails_env}"
  end
end
