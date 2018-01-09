#!/bin/sh

if [ "$TRAVIS_BRANCH" == "develop" ]; then
  bundle exec cap production deploy
fi
