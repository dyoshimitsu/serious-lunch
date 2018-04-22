# frozen_string_literal: true

class Account::AccountRemember
  include Virtus.model

  attribute :account, Account, reader: :private

  def account_remember
    account.remember_token = Account::AccountAuthenticator.new_token
    digest = Account::AccountAuthenticator.digest(account.remember_token)
    time = Time.zone.now.strftime('%F %T')

    sql = <<~SQL
      INSERT INTO account_cookies (
        account_id, remember_digest, created_at, updated_at
      ) VALUES (
        #{account.account_id},
        '#{digest}',
        '#{time}',
        '#{time}'
      )
      ON DUPLICATE KEY UPDATE
        remember_digest = '#{digest}',
        updated_at      = '#{time}'
    SQL
    ActiveRecord::Base.connection.execute(sql)
  end

  def account_forget
    AccountCookie.delete(account_id: account)
  end
end
