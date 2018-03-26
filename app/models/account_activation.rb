# frozen_string_literal: true

class AccountActivation < ApplicationRecord
  belongs_to :account

  attr_accessor :activation_token
  before_create :create_activation_digest

  def authenticated?
    Account::Authenticator.authenticated?(activation_digest, activation_token)
  end

  private

  def create_activation_digest
    self.activation_token = Account::Authenticator.new_token
    self.activation_digest = Account::Authenticator.digest(activation_token)
  end
end
