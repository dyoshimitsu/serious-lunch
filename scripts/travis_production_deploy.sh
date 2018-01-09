#!/bin/sh

bundle exec rails db:migrate:status
bundle exec cap production deploy
