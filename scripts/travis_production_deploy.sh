#!/bin/sh

echo $TRAVIS_BRANCH
if [ "$TRAVIS_BRANCH" = master ] && [ "$TRAVIS_BRANCH" = develop ]; then
  echo "hoge"
  bundle exec cap production deploy
fi
