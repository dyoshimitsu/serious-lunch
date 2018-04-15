# frozen_string_literal: true

class Account::AccountPasswordResetter
  include Virtus.model

  attribute :account, Account, reader: :private

  def account_password_reset
    account.reset_token = Account::AccountAuthenticator.new_token
    digest = Account::AccountAuthenticator.digest(account.reset_token)
    time = Time.zone.now.strftime('%F %T')

    sql = <<~SQL
      INSERT INTO account_resets (
        account_id, reset_digest, created_at, updated_at
      ) VALUES (
        #{account.account_id},
        '#{digest}',
        '#{time}',
        '#{time}'
      )
      ON DUPLICATE KEY UPDATE
        reset_digest = '#{digest}',
        updated_at   = '#{time}'
    SQL
    ActiveRecord::Base.connection.execute(sql)

    Account::AccountMailer.new(account: account).send_password_reset_email
  end

  def password_reset_expired?
    (account&.account_reset&.updated_at) < 30.minutes.ago
  end
end
