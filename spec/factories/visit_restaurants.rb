# frozen_string_literal: true

FactoryBot.define do
  factory :visit_restaurant do
    association :account, factory: :account
    comment { nil }
  end
end
