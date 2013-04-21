web: bundle exec rails server -p $PORT
worker: bundle exec rake jobs:work
resque: env TERM_CHILD=1 bundle exec rake jobs:work
