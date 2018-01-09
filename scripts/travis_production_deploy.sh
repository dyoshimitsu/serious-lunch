#!/bin/sh

if [ "$TRAVIS_BRANCH" == "prod" ]; then
  bundle exec cap production deploy
fi
