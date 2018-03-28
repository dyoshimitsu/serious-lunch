# frozen_string_literal: true

FactoryBot.define do
  factory :account_activation do
    association :account, factory: :account
    activated { true }
    activation_digest { '' }
  end
end
