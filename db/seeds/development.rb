# frozen_string_literal: true

foo = Account.find_or_create_by(account_id: 1) do |record|
  record.assign_attributes(
    account_name: 'foo',
    email_address: 'foo@example.com',
    password: 'password',
    activated: true,
    activated_at: Time.zone.now
  )
end

Account.find_or_create_by(account_id: 2) do |record|
  record.assign_attributes(
    account_name: 'bar',
    email_address: 'bar@example.com',
    password: 'password',
    activated: true,
    activated_at: Time.zone.now
  )
end

VisitRestaurant.find_or_create_by(visit_restaurant_id: 1) do |record|
  record.assign_attributes(
    account: foo,
    comment: 'excellent'
  )
end

VisitRestaurant.find_or_create_by(visit_restaurant_id: 2) do |record|
  record.assign_attributes(
    account: foo,
    comment: 'good'
  )
end
