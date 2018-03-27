# frozen_string_literal: true

class AccountActivation < ApplicationRecord
  belongs_to :account

  attr_accessor :activation_token
  before_create :create_activation_digest

  def authenticated?(activation_token)
    Account::AccountAuthenticator.authenticated?(activation_digest, activation_token)
  end

  def activate
    update_attribute(activated, true)
  end

  private

  def create_activation_digest
    self.activation_token = Account::AccountAuthenticator.new_token
    self.activation_digest = Account::AccountAuthenticator.digest(activation_token)
  end
end
