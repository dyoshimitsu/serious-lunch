# frozen_string_literal: true

class AccountActivation < ApplicationRecord
  belongs_to :account

  attr_accessor :activation_token
  before_create :create_activation_digest

  private

  def create_activation_digest
    self.activation_token = Account.new_token
    self.activation_digest = Account.digest(activation_token)
  end
end
