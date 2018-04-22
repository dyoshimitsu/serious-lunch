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

  def account_activate
    AccountActivation.where(account: account)
                     .update_all(activated: true, updated_at: Time.now)
  end

  def account_activated?
    account&.account_activation&.activated
  end
end
