# frozen_string_literal: true

class AccountReset < ApplicationRecord
  belongs_to :account

  attr_accessor :reset_token

  def authenticated?
    Account::Authenticator.authenticated?(reset_digest, reset_token)
  end
end
