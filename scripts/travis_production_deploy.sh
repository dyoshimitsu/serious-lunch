#!/usr/bin/env bash

echo $TRAVIS_BRANCH
if [ "$TRAVIS_BRANCH" == "master" ] && [ "$TRAVIS_BRANCH" == "develop" ]; then
  echo "true"
  bundle exec cap production deploy
fi
