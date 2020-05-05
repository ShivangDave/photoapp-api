#!/bin/sh

rm -f tmp/pids/server.pid
bundle exec rake db:migrate
bundle exec rails s -b 0.0.0.0 -p $PORT 