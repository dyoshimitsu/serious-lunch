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

bar = Account.find_or_create_by(account_id: 2) do |record|
  record.assign_attributes(
    account_name: 'bar',
    email_address: 'bar@example.com',
    password: 'password',
    activated: true,
    activated_at: Time.zone.now
  )
end

Lunch.find_or_create_by(lunch_id: 1) do |record|
  record.assign_attributes(
    account: foo,
    lunch_date: Date.new(2018, 3, 9),
    comment: 'excellent'
  )
end

Lunch.find_or_create_by(lunch_id: 2) do |record|
  record.assign_attributes(
    account: bar,
    lunch_date: Date.new(2018, 3, 9),
    comment: 'bad'
  )
end

Lunch.find_or_create_by(lunch_id: 3) do |record|
  record.assign_attributes(
    account: foo,
    lunch_date: Date.new(2018, 3, 8),
    comment: 'good'
  )
end
