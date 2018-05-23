# frozen_string_literal: true

FactoryBot.define do
  factory :account_relationship do
    association :follower_account, factory: :account
    association :followed_account, factory: :account
  end
end
