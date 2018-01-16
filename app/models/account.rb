# frozen_string_literal: true

class Account < ApplicationRecord
  validates :account_name, format: { with: /\A[0-9a-zA-Z_]+\z/ }

  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }
end
