# frozen_string_literal: true

FactoryBot.define do
  factory :visit_restaurant do
    association :account, factory: :account
    visit_date { Time.zone.parse('2018-03-05T00:00+09:00') }
    comment { nil }
  end
end
