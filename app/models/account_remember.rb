# frozen_string_literal: true

class AccountRemember < ApplicationRecord
  belongs_to :account

  attr_accessor :remember_token

  def authenticated?
    Account::Authenticator.authenticated?(remember_digest, remember_token)
  end

  def remember
    self.remember_token = Account::Authenticator.new_token
    update_attribute(
      :remember_digest, Account::Authenticator.digest(remember_token)
    )
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
