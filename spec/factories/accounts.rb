# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    sequence :account_name, &:to_s
    sequence :email_address do |n|
      "#{n}@example.com"
    end

    password { 'password' }

    trait :with_account_activation do
      after(:create) do |account|
        create(:account_activation, account: account)
      end
    end
  end
end
