# frozen_string_literal: true

class AccountReset < ApplicationRecord
  belongs_to :account

  attr_accessor :reset_token

  def authenticated?(reset_token)
    Account::AccountAuthenticator.authenticated?(reset_digest, reset_token)
  end

  def create_reset_digest
    self.reset_token = Account::AccountAuthenticator.new_token
    update_attribute(
      :reset_digest, Account::AccountAuthenticator.digest(reset_token)
    )
  end

  def password_reset_expired?
    updated_at < 30.minutes.ago
  end
end
