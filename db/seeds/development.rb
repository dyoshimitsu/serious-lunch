# frozen_string_literal: true

Account.find_or_create_by(account_id: 1) do |record|
  record.assign_attributes(
    account_name: 'foo',
    email: 'foo@example.com',
    password: 'password'
  )
end

Account.find_or_create_by(account_id: 2) do |record|
  record.assign_attributes(
    account_name: 'bar',
    email: 'bar@example.com',
    password: 'password'
  )
end
