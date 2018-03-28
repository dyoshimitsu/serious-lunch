# frozen_string_literal: true

class Account::AccountPasswordResetter
  include Virtus.model

  attribute :account, Account, reader: :private

  def account_password_reset
    account.reset_token = Account::AccountAuthenticator.new_token
    AccountReset.create(
      account_id: account.account_id,
      reset_digest: Account::AccountAuthenticator.digest(account.reset_token)
    )
    Account::AccountMailer.new(account: account).send_password_reset_email
  end

  def password_reset_expired?
    account&.account_reset.updated_at < 30.minutes.ago
  end
end
