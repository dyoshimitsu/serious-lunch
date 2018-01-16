# frozen_string_literal: true

class Account < ApplicationRecord
  has_secure_password

  validates :account_name, format: { with: /\A[0-9a-zA-Z_]+\z/ }
  validates :password, length: { minimum: 8 }
end
