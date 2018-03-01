# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    account_name { 'foo' }
    email_address { 'foo@example.com' }
    password { 'password' }
    activated { true }
  end
end
