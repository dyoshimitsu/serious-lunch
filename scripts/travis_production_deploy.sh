#!/usr/bin/env bash

if [ "$TRAVIS_BRANCH" == "master" ] || [ "$TRAVIS_BRANCH" == "develop" ]; then
  ls -la ~/.ssh
  openssl aes-256-cbc -K $encrypted_3b954893797a_key -iv $encrypted_3b954893797a_iv -in config/serious_lunch.enc -out ~/.ssh/serious_lunch -d
  chmod 600 ~/.ssh/serious_lunch
  bundle exec cap production deploy
fi
