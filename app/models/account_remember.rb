# frozen_string_literal: true

class AccountRemember < ApplicationRecord
  belongs_to :account

  attr_accessor :remember_token

  def authenticated?
    Account::Authenticator.authenticated?(remember_digest, remember_token)
  end
end
