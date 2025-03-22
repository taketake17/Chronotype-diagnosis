set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:migrate
bundle exec rails runner 'DefaultSchedule.destroy_all'
bundle exec rails db:seed