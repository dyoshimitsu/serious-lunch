# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    sequence :account_name, &:to_s
    sequence :email_address do |n|
      "#{n}@example.com"
    end

    password { 'password' }
  end
end
