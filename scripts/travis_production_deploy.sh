#!/usr/bin/env bash

if [ "$TRAVIS_BRANCH" == "master" ] && [ "$TRAVIS_BRANCH" == "develop" ]; then
  bundle exec cap production deploy
fi
