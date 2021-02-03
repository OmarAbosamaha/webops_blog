#!bin/bash
rm -f tmp/pids/server.pid
bundle exec rails db:create db:migrate
puma
