# frozen_string_literal: true

class AccountRemember < ApplicationRecord
  belongs_to :account

  attr_accessor :remember_token

  def authenticated?(remember_token)
    Account::AccountAuthenticator.authenticated?(remember_digest, remember_token)
  end

  def remember
    self.remember_token = Account::AccountAuthenticator.new_token
    update_attribute(
      :remember_digest, Account::AccountAuthenticator.digest(remember_token)
    )
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
