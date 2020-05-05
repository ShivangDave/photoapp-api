#!/bin/sh

rm -f tmp/pids/server.pid
bin/rails db:migrate
bin/rails server -b 0.0.0.0 -p $PORT