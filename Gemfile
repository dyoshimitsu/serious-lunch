# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "rails", "~> 5.2.0.bata2"

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use mysql as the database for Active Record
gem "mysql2"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platform: :mri
  gem "dotenv-rails"
  gem "onkcop", require: false
  gem "rubocop"
end

group :test do
  gem "factory_bot_rails"
  gem "rspec-rails"
end
