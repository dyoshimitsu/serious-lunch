# frozen_string_literal: true

class Account::AccountRemember
  include Virtus.model

  attribute :account, Account, reader: :private

  def account_remember
    account.remember_token = Account::AccountAuthenticator.new_token
    AccountCookie.create(
      account_id: account.account_id,
      remember_digest: Account::AccountAuthenticator.digest(account.remember_token)
    )
  end

  def account_forget
    AccountCookie.delete(account_id: account)
  end
end
