# frozen_string_literal: true

FactoryBot.define do
  factory :lunch do
    association :account, factory: :account
    lunch_date { Date.new(2018, 3, 9) }
    comment { nil }
  end
end
