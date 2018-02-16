# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    account_name { 'foo' }
    email { 'foo@example.com' }
    password { 'password' }
    activated { true }
  end
end
