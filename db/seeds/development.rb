# frozen_string_literal: true

Account.find_or_create_by(account_id: 1) do |record|
  record.assign_attributes(
    account_name: 'foo',
    email: 'foo@example.com',
    password: 'password',
    activated: true,
    activated_at: Time.zone.now
  )
end

Account.find_or_create_by(account_id: 2) do |record|
  record.assign_attributes(
    account_name: 'bar',
    email: 'bar@example.com',
    password: 'password',
    activated: true,
    activated_at: Time.zone.now
  )
end
