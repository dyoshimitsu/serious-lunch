# frozen_string_literal: true

class Account::AccountActivator
  include Virtus.model

  attribute :account, Account, reader: :private

  def account_activation
    account.activation_token = Account::AccountAuthenticator.new_token
    AccountActivation.create(
      account_id: account.account_id,
      activation_digest: Account::AccountAuthenticator.digest(account.activation_token)
    )
    Account::AccountMailer.new(account: account).send_activation_email
  end
end
